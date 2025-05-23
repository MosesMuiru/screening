defmodule WinnerWeb.CurrencyLiveTest do
  use WinnerWeb.ConnCase

  import Phoenix.LiveViewTest
  import Winner.ConversionsFixtures

  @create_attrs %{amount: 42, from_currency: "some from_currency", target_currency: "some target_currency"}
  @update_attrs %{amount: 43, from_currency: "some updated from_currency", target_currency: "some updated target_currency"}
  @invalid_attrs %{amount: nil, from_currency: nil, target_currency: nil}

  defp create_currency(_) do
    currency = currency_fixture()
    %{currency: currency}
  end

  describe "Index" do
    setup [:create_currency]

    test "lists all currencies", %{conn: conn, currency: currency} do
      {:ok, _index_live, html} = live(conn, ~p"/currencies")

      assert html =~ "Listing Currencies"
      assert html =~ currency.from_currency
    end

    test "saves new currency", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/currencies")

      assert index_live |> element("a", "New Currency") |> render_click() =~
               "New Currency"

      assert_patch(index_live, ~p"/currencies/new")

      assert index_live
             |> form("#currency-form", currency: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#currency-form", currency: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/currencies")

      html = render(index_live)
      assert html =~ "Currency created successfully"
      assert html =~ "some from_currency"
    end

    test "updates currency in listing", %{conn: conn, currency: currency} do
      {:ok, index_live, _html} = live(conn, ~p"/currencies")

      assert index_live |> element("#currencies-#{currency.id} a", "Edit") |> render_click() =~
               "Edit Currency"

      assert_patch(index_live, ~p"/currencies/#{currency}/edit")

      assert index_live
             |> form("#currency-form", currency: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#currency-form", currency: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/currencies")

      html = render(index_live)
      assert html =~ "Currency updated successfully"
      assert html =~ "some updated from_currency"
    end

    test "deletes currency in listing", %{conn: conn, currency: currency} do
      {:ok, index_live, _html} = live(conn, ~p"/currencies")

      assert index_live |> element("#currencies-#{currency.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#currencies-#{currency.id}")
    end
  end

  describe "Show" do
    setup [:create_currency]

    test "displays currency", %{conn: conn, currency: currency} do
      {:ok, _show_live, html} = live(conn, ~p"/currencies/#{currency}")

      assert html =~ "Show Currency"
      assert html =~ currency.from_currency
    end

    test "updates currency within modal", %{conn: conn, currency: currency} do
      {:ok, show_live, _html} = live(conn, ~p"/currencies/#{currency}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Currency"

      assert_patch(show_live, ~p"/currencies/#{currency}/show/edit")

      assert show_live
             |> form("#currency-form", currency: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#currency-form", currency: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/currencies/#{currency}")

      html = render(show_live)
      assert html =~ "Currency updated successfully"
      assert html =~ "some updated from_currency"
    end
  end
end
