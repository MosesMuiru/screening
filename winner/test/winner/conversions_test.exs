defmodule Winner.ConversionsTest do
  use Winner.DataCase

  alias Winner.Conversions

  describe "currencies" do
    alias Winner.Conversions.Currency

    import Winner.ConversionsFixtures

    @invalid_attrs %{amount: nil, from_currency: nil, target_currency: nil}

    test "list_currencies/0 returns all currencies" do
      currency = currency_fixture()
      assert Conversions.list_currencies() == [currency]
    end

    test "get_currency!/1 returns the currency with given id" do
      currency = currency_fixture()
      assert Conversions.get_currency!(currency.id) == currency
    end

    test "create_currency/1 with valid data creates a currency" do
      valid_attrs = %{amount: 42, from_currency: "some from_currency", target_currency: "some target_currency"}

      assert {:ok, %Currency{} = currency} = Conversions.create_currency(valid_attrs)
      assert currency.amount == 42
      assert currency.from_currency == "some from_currency"
      assert currency.target_currency == "some target_currency"
    end

    test "create_currency/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Conversions.create_currency(@invalid_attrs)
    end

    test "update_currency/2 with valid data updates the currency" do
      currency = currency_fixture()
      update_attrs = %{amount: 43, from_currency: "some updated from_currency", target_currency: "some updated target_currency"}

      assert {:ok, %Currency{} = currency} = Conversions.update_currency(currency, update_attrs)
      assert currency.amount == 43
      assert currency.from_currency == "some updated from_currency"
      assert currency.target_currency == "some updated target_currency"
    end

    test "update_currency/2 with invalid data returns error changeset" do
      currency = currency_fixture()
      assert {:error, %Ecto.Changeset{}} = Conversions.update_currency(currency, @invalid_attrs)
      assert currency == Conversions.get_currency!(currency.id)
    end

    test "delete_currency/1 deletes the currency" do
      currency = currency_fixture()
      assert {:ok, %Currency{}} = Conversions.delete_currency(currency)
      assert_raise Ecto.NoResultsError, fn -> Conversions.get_currency!(currency.id) end
    end

    test "change_currency/1 returns a currency changeset" do
      currency = currency_fixture()
      assert %Ecto.Changeset{} = Conversions.change_currency(currency)
    end
  end
end
