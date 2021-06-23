From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 24 Jun 2021 08:38:54 +0930
Subject: [PATCH] ARM: dts: aspeed: Rainier remove PSU gpio-keys
In-Reply-To: <20210623230401.3050076-1-bjwyman@gmail.com>
References: <20210623230401.3050076-1-bjwyman@gmail.com>
Message-ID: <7365c20e-541c-4e32-a907-0519534117ae@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 24 Jun 2021, at 08:34, Brandon Wyman wrote:
> From: "B. J. Wyman" <bjwyman@gmail.com>
> 
> Remove the gpio-keys entries for the power supply presence lines from
> the Rainier device tree. The user space applications are going to change
> from using libevdev to libgpiod.
> 

Have they already added support for libgpiod? We should support both at 
least while we're switching over.

Andrew
