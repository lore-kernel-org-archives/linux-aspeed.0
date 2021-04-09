From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 9 Apr 2021 09:55:53 +0200
Subject: [PATCH v2 16/21] ipmi: kcs_bmc: Add a "raw" character device
 interface
In-Reply-To: <20210319062752.145730-16-andrew@aj.id.au>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-16-andrew@aj.id.au>
Message-ID: <CAK8P3a1HDQdbTAT4aRMLu-VFz720ynPqPHG5b22NZ5p5QfUqOw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 19, 2021 at 7:31 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The existing IPMI chardev encodes IPMI behaviours as the name suggests.
> However, KCS devices are useful beyond IPMI (or keyboards), as they
> provide a means to generate IRQs and exchange arbitrary data between a
> BMC and its host system.

I only noticed the series after Joel asked about the DT changes on the arm
side. One question though:

How does this related to the drivers/input/serio/ framework that also talks
to the keyboard controller for things that are not keyboards? Are these
separate communication channels on adjacent I/O ports, or does there
need to be some arbitration?

       Arnd
