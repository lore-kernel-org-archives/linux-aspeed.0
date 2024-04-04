From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 04 Apr 2024 11:47:38 +1030
Subject: [PATCH v2 1/3] ARM: dts: Modify GPIO table for Asrock X570D4U
 BMC
In-Reply-To: <20240403133037.37782-2-renze@rnplus.nl>
References: <20240403133037.37782-1-renze@rnplus.nl>
	 <20240403133037.37782-2-renze@rnplus.nl>
Message-ID: <77829355a18f2afd64343e7e19498473d9263ef6.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Renze,

In the future, the start of the subject should also include 'aspeed: ',
so:

    ARM: dts: aspeed: Modify GPIO table for Asrock X570D4U BMC

On Wed, 2024-04-03 at 15:28 +0200, Renze Nicolai wrote:
> Restructure GPIO table to fit maximum line length.
> 
> Fix mistakes found while working on OpenBMC
> userland configuration and based on probing
> the board.
> 
> Schematic for this board is not available.
> Because of this the choice was made to
> use a descriptive method for naming the
> GPIOs.
> 
>  - Push-pull outputs start with output-*
>  - Open-drain outputs start with control-*
>  - LED outputs start with led-*
>  - Inputs start with input-*
>  - Button inputs start with button-*
>  - Active low signals end with *-n

This seems to be a bit of a mix of following conventions in [1] and
not. It might be helpful to weigh in on that document with your ideas.

[1]: https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

I'll put this series in a tree for Joel for now though, with the
subject fix mentioned above.

I've also re-wrapped the commit messages as it seems you stopped a bit
short of the allowable line length.

Andrew
