From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu, 24 Oct 2019 11:03:13 -0700
Subject: AST2600 i2c irq issue
In-Reply-To: <333e959f-9296-b6d5-9442-b979a8abd50d@linux.vnet.ibm.com>
References: <CACPK8XdqFkPgCQcgpM5C_YwfJ86Lmk=hG5zTcfbCDCMncXCJMg@mail.gmail.com>
 <f9fecc04-2a9a-4cbd-a1ff-ffb680b0fec2@linux.vnet.ibm.com>
 <dbb8635e-a95a-3951-cd65-3428adc461ec@linux.intel.com>
 <8c62b118777c44d1bf8e1a3c32175644@TWMBX02.aspeed.com>
 <333e959f-9296-b6d5-9442-b979a8abd50d@linux.vnet.ibm.com>
Message-ID: <5508f358-77b8-f5f7-2577-79da25e4e5ea@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

On 10/22/2019 1:24 PM, Eddie James wrote:

[...]

> 7: irq[00000000] before[rx] after[stop]

'irq[]' here and '10[]' below are the same register. This log means an
interrupt came with empty status.

>  ??? 00[00008001]
>  ??? 04[007ee005]
>  ??? 08[00000000]
>  ??? 0c[0000607f]
>  ??? 10[00000004]??? <<< this is interesting. this has changed since the 
> start of the interrupt handler.

The interrupt status was updated lately at here. Looks like there is a
timing gap in H/W between interrupt triggering and status updating. I
haven't seen this issue in previous H/W versions.

This issue can be resolved by your patch but ultimately this issue
should be fixed in AST2600 A1 revision H/W if possible so that we can
remove the unnecessary interrupt handling.

Thanks,

Jae
