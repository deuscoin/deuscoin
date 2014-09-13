// Copyright (c) 2011-2014 The Bitcoin Core and Deuscoin Core developers
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef DEUSCOINADDRESSVALIDATOR_H
#define DEUSCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class DeuscoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit DeuscoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Deuscoin address widget validator, checks for a valid deuscoin address.
 */
class DeuscoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit DeuscoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // DEUSCOINADDRESSVALIDATOR_H
