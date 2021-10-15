From: 王擎 <wangqing@vivo.com>
Date: Fri, 15 Oct 2021 07:13:58 +0000
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHR0eTogODI1MDogcmVwbGFjZSBzbnByaW50ZiBp?=
 =?utf-8?Q?n_show_functions_with_sysfs=5Femit?=
In-Reply-To: <AOQACwDzEi5UM3m3ezm-D4o5.9.1634281082401.Hmail.wangqing@vivo.com>
References: <1634280682-5002-1-git-send-email-wangqing@vivo.com>
 <AOQACwDzEi5UM3m3ezm-D4o5.9.1634281082401.Hmail.wangqing@vivo.com>
Message-ID: <SL2PR06MB30828C16C885776950205E5DBDB99@SL2PR06MB3082.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


>> show() must not use snprintf() when formatting the value to be
>> returned to user space.
>
>Why must it not?? What is broken in the existing code?

Replyed in another email.

>
>> 
>> Fix the coccicheck warnings:
>> WARNING: use scnprintf or sprintf.
>> 
>> Signed-off-by: Qing Wang <wangqing@vivo.com>
>> ---
>>? drivers/tty/serial/8250/8250_aspeed_vuart.c | 6 +++---
>>? drivers/tty/serial/8250/8250_port.c???????? | 2 +-
>>? 2 files changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> index 2350fb3..082b9bd 100644
>> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> @@ -82,7 +82,7 @@ static ssize_t lpc_address_show(struct device *dev,
>>??????? addr = (aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRH) << 8) |
>>??????????????? (aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRL));
>>? 
>> -???? return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
>> +???? return sysfs_emit(buf - 1, "0x%x\n", addr);
>
>what is the buf-1 thing here for?
>
>Doing a tree-wide change for this type of thing might not be wanted by
>many maintainers, especially if you introduce bugs like this :(

Sorry for this, my tool needs to be optimized.
Please ignore this patch.

Thanks,

Qing
>
>greg k-h
>
