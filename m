From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 24 Jan 2020 10:31:30 +1030
Subject: [PATCH v2] ARM: dts: aspeed: update Hr855xg2 device tree
In-Reply-To: <20200123085112.8371-1-pengms1@lenovo.com>
References: <20200123085112.8371-1-pengms1@lenovo.com>
Message-ID: <1c13de6c-3bee-4afc-8a03-691222b07ebe@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 23 Jan 2020, at 19:21, Andrew Peng wrote:
> Update i2c aliases.
> Change flash_memory mapping address and size.
> Add in a gpio-keys section.
> Add in a peci0 section.
> Update i2c0,i2c0 and i2c11 section.
> Enable vhub, vuart, spi1 and spi2.
> Remove gpio from gpio section since it controlled by user space.

These seem like largely independent items. I'd prefer that you have
one commit for each item in the list, that way it's easier to review
and understand the relationships between the bits of affected code.
Basically, don't give people reasons to say no to your patches :) The
smaller and more coherent the change, the easier it is to give it a
Reviewed-by or Acked-by tag.

Also commit messages should say _why_ you're making the changes
not _what_ changes you're making. The diff tells us _what_, but nothing
besides comments and the commit message can tell us why. It's much
more convincing if you explain why your patch must be applied.

Andrew
