From: David Miller <davem@davemloft.net>
Date: Thu, 11 Mar 2021 16:28:45 -0800 (PST)
Subject: [PATCH 4/4] ftgmac100: Restart MAC HW once
In-Reply-To: <CACPK8XfMEy2o39v3CG4Zzj9H_kqSFBOddL3SC-_OryMqVXEjOw@mail.gmail.com>
References: <20201019085717.32413-5-dylan_hung@aspeedtech.com>
 <CACPK8Xc8NSBzN+LnZ=b5t7ODjLg9B6m2WDdR-C9SRWaDEXwOtQ@mail.gmail.com>
 <CACPK8XfMEy2o39v3CG4Zzj9H_kqSFBOddL3SC-_OryMqVXEjOw@mail.gmail.com>
Message-ID: <20210311.162845.1107113962810628804.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 Mar 2021 00:26:43 +0000

> On Tue, 20 Oct 2020 at 04:14, Joel Stanley <joel@jms.id.au> wrote:
>>
>> On Mon, 19 Oct 2020 at 08:57, Dylan Hung <dylan_hung@aspeedtech.com> wrote:
>> >
>> > The interrupt handler may set the flag to reset the mac in the future,
>> > but that flag is not cleared once the reset has occured.
>> >
>> > Fixes: 10cbd6407609 ("ftgmac100: Rework NAPI & interrupts handling")
>> > Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
>> > Signed-off-by: Joel Stanley <joel@jms.id.au>
>>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> net maintainers, this one never made it into the tree. Do you need me
> to re-send it?

If it has been this long, definitely you need to resend.

