From: Ninad Palsule <ninad@linux.ibm.com>
Date: Thu, 1 Aug 2024 09:32:08 -0500
Subject: [PATCH v1 1/1] ARM: dts: aspeed: system1: IBM System1 BMC update
In-Reply-To: <5d86ab31-7b29-4f5e-9c9f-be904c128497@linux.ibm.com>
References: <20240731214737.986010-1-ninad@linux.ibm.com>
 <20240731214737.986010-2-ninad@linux.ibm.com>
 <5d86ab31-7b29-4f5e-9c9f-be904c128497@linux.ibm.com>
Message-ID: <b7eeefed-8d84-4f14-9d72-ea16d4e1458f@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

On 7/31/24 16:57, Eddie James wrote:
>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts 
>> b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> index f3efecc7eb8d0..f96b299d743ba 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -764,17 +764,113 @@ regulator at 43 {
>> ????? };
>> ? };
>> ? +
>
>
> Don't really need the white space here, but no worries.
I have fixed the whitespace in version 2.
>
>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>
>
>
Thank you for the review!

Regards,

Ninad Palsule

