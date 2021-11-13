From: Richard Hughes <hughsient@gmail.com>
Date: Sat, 13 Nov 2021 09:48:36 +0000
Subject: [PATCH] ARM: configs: aspeed: Add support for USB flash drives
In-Reply-To: <20211113002948.GE14774@packtop>
References: <20211112202931.2379145-1-anoo@linux.ibm.com>
 <20211113002948.GE14774@packtop>
Message-ID: <CAD2FfiH2YaD=m0wPrqEaKaUtJDEHmxMXwCU3LW9UdOfC+AnCeQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 13 Nov 2021 at 01:58, Zev Weiss <zweiss@equinix.com> wrote:
> Hmm, how common is it for BMCs to have a USB port?

If it helps, the evb-ast2500 has a couple of USB ports, and I've
actually been trying to enable USB (additionally with CONFIG_HIDRAW)
so that I can do a demo that uses fwupd to update the firmware on the
attached keyboard or mouse.

Richard
