From: Greg KH <greg@kroah.com>
Date: Fri, 9 Oct 2020 06:45:05 +0200
Subject: [PATCH v2 2/3] usb: host: add uhci compatible support for
 ast2600-uhci
In-Reply-To: <20201009024937.11246-3-ryan_chen@aspeedtech.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-3-ryan_chen@aspeedtech.com>
Message-ID: <20201009044505.GA111063@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 09, 2020 at 10:49:36AM +0800, Ryan Chen wrote:
> v2:
>  - Fix continuation lines, align with "of_device"
> v1:
>  - Add support for AST2600 SOC UHCI driver.

These all go below the --- line, as the kernel documentation asks for.

> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

You have no changelog text here at all, and I can't take that, sorry.
Please fix this up and resend with a proper changelog text.

thanks,

greg k-h
