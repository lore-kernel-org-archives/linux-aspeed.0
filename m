From: Olof Johansson <olof@lixom.net>
Date: Mon, 29 Apr 2019 09:32:29 -0700
Subject: [PATCH] soc: add aspeed folder and misc drivers
In-Reply-To: <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
References: <20190422173838.182736-1-venture@google.com>
 <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
Message-ID: <20190429163229.ibeny5r4islxiyrp@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 23, 2019 at 10:08:11AM +0200, Arnd Bergmann wrote:
> On Mon, Apr 22, 2019 at 7:38 PM Patrick Venture <venture@google.com> wrote:
> >
> > Create a SoC folder for the ASPEED parts and place the misc drivers
> > currently present into this folder.  These drivers are not generic part
> > drivers, but rather only apply to the ASPEED SoCs.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> 
> Looks ok, but please resend to arm at kernel.org or soc at kernel.org
> so we can track the submission and make sure it gets applied if
> you want this to go through the arm-soc tree.
> 
> If Greg wants to pick it up, that's fine too.
> 
> Either way,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to the SoC tree now.


-Olof
