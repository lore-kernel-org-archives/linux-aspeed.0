From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Mon, 06 May 2019 15:40:47 -0500
Subject: [PATCH dev-5.0 v3] ARM: dts: aspeed: Add Swift BMC machine
In-Reply-To: <CAK_vbW2X1DLqBi4EbPH9Cw0FM3o1P2SRguKVkkK47UYPCyxJdQ@mail.gmail.com>
References: <5bbc8649-5a38-fe38-9a97-9c4ec582b511@linux.ibm.com>
 <1556572128-20917-1-git-send-email-anoo@linux.ibm.com>
 <CAK_vbW2X1DLqBi4EbPH9Cw0FM3o1P2SRguKVkkK47UYPCyxJdQ@mail.gmail.com>
Message-ID: <67fa3f20dacbed3cec61af33e85664a4@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


>> +
>> +               rear-power {
>> +                       gpios = <&gpio ASPEED_GPIO(N, 3) 
>> GPIO_ACTIVE_LOW>;
>> +               };
> 
> Are you sure about this one? I see GPION3 as a no connect.
> 

You're right, this has been removed in the latest version of the 
schematics. Will remove it.

