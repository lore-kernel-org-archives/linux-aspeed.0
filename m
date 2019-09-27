From: Hongwei Zhang <hongweiz@ami.com>
Date: Fri, 27 Sep 2019 11:55:48 -0400
Subject: [v2, 2/2] gpio: dts: aspeed: Add SGPIO driver
In-Reply-To: <1569439337-10482-3-git-send-email-hongweiz@ami.com>
References: <1569439337-10482-3-git-send-email-hongweiz@ami.com>
Message-ID: <1569599748-31181-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks Linus,

> 
> I sent a separate patch to fix this up the way I want it with the file named gpio-aspeed-sgpio.c and 
> CONFIG_GPIO_ASPEED_SGPIO.
> 
> I don't want to mix up the namespaces of something Aspeed-generic with the namespace of the GPIO 
> subsystem. SGPIO is the name of a specific Aspeed component.
> 
> Yours,
> Linus Walleij

I agree and gpio-aspeed-sgpio.c is better.

Regards,
--Hongwei
