From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 15 Nov 2021 10:56:33 +1030
Subject: [PATCH] ARM: configs: aspeed: Add support for USB flash drives
In-Reply-To: <20211113002948.GE14774@packtop>
References: <20211112202931.2379145-1-anoo@linux.ibm.com>
 <20211113002948.GE14774@packtop>
Message-ID: <65620ec1-94fb-48f7-a8f8-8e9f409b0fc8@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 13 Nov 2021, at 10:59, Zev Weiss wrote:
> On Fri, Nov 12, 2021 at 12:29:31PM PST, Adriana Kobylak wrote:
>>From: Adriana Kobylak <anoo@us.ibm.com>
>>
>>Add support to detect USB flash drives and create the /dev/sd* devices.
>>Also add support for vfat to support USB drives formatted as FAT32.
>>This support will be used to enable firmware updates via USB flash
>>drives where the firmware image is stored in the USB drive and it's
>>plugged into the BMC USB port.
>>
>
> Hmm, how common is it for BMCs to have a USB port?  Perhaps it's more so
> than I realize, but at least in my (admittedly somewhat limited)
> experience I've yet to encounter one that does, so I'm wondering how
> appropriate these options are for the aspeed-g5 defconfig if they might
> just end up as a bunch of code that's never executed on most BMCs.

The intent with the Aspeed defconfigs was to enable options that 
provide a broad coverage of features used by e.g. upstream OpenBMC 
systems. This aids kernel maintenance for OpenBMC. The platform 
configuration in OpenBMC should provide a kernel config that only 
enables options relevant to that specific platform. With this in mind I 
think it's fine that USB support is enabled in the defconfigs.

Andrew
