From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 12 Sep 2024 11:40:48 +0930
Subject: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506
 for CPLD IOE
In-Reply-To: <20240910054751.2943217-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240910054751.2943217-3-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <ccef1d90b9a7eb343e99afa2c6cd6ea7407b0541.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-09-10 at 13:47 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> We use CPLD to emulate gpio pca9506 I/O expander on each server
> boards.
> Therefore, add pca9506 to probe driver for the CPLD I/O expander.

I think it might be best if you add your own compatible to the list in
the gpio-pca95xx binding just in case there are some behavioural quirks
of your CPLD implementation? Not sure if this should be
"facebook,pca9506" or "wywinn,pca9506", but assuming facebook, from
there you can specify

    compatible = "facebook,pca9506", "nxp,pca9506";

This allows you to add the quirks to the driver as required in the
future through the more-specific compatible.

Andrew
