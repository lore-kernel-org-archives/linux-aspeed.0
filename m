From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 11 Dec 2019 10:02:22 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v2_01/12]_dt-bindings:_interrupt-controller:_Add_As?=
 =?UTF-8?Q?peed_SCU_interrupt_controller?=
In-Reply-To: <1575566112-11658-2-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-2-git-send-email-eajames@linux.ibm.com>
Message-ID: <e8d37ccd-ffe3-4969-b2db-9519e68da086@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> Document the Aspeed SCU interrupt controller and add an include file
> for the interrupts it provides.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v1:
>  - Remove 'reg' required property.

Hmm, I have a series that rearranges the SCU bindings to fix up some
issues we have with dtc warnings. I'm happy for this to go in now as it's
consistent with what we have as my patches are not yet merged,  but
we should circle back later.

Acked-by: Andrew Jeffery <andrew@aj.id.au>
