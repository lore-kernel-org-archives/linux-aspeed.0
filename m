From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 09 Apr 2021 14:54:08 +0930
Subject: [PATCH v2 01/21] dt-bindings: aspeed-lpc: Remove LPC partitioning
In-Reply-To: <CACPK8Xdw3+2Rt=tQ-ciusyK=W6BaP_DR4FSFp0qDuPq5z8MPBQ@mail.gmail.com>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <CACPK8Xdw3+2Rt=tQ-ciusyK=W6BaP_DR4FSFp0qDuPq5z8MPBQ@mail.gmail.com>
Message-ID: <a181f404-ea59-4956-abe3-60d0bee917d2@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 9 Apr 2021, at 12:48, Joel Stanley wrote:
> On Fri, 19 Mar 2021 at 06:28, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > From: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
> >
> > The LPC controller has no concept of the BMC and the Host partitions.
> > This patch fixes the documentation by removing the description on LPC
> > partitions. The register offsets illustrated in the DTS node examples
> > are also fixed to adapt to the LPC DTS change.
> 
> Is this accurate:
> 
>  The node examples change their reg address to be an offset from the
> LPC HC to be an offset from the base of the LPC region.

Everything becomes based from the start of the LPC region, yes.

Andrew
