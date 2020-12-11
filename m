From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Dec 2020 11:09:39 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.11, round two
Message-ID: <CACPK8XfkZq51yKJUjyqgKD=R-WZiCR0J18GJBbo=tfMKMMddSQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc team,

Here are some late changes for the aspeed boards. Most are fixes, and
the addition of a new machine from Ampere.

(Arnd, I realised when sending the LPC clock fix that we had a few
others fixes, so he's a pull request instead)

The following changes since commit 5124cff93d99bbfe1efc8deb0c0b3604cb9a6659:

  ARM: dts: aspeed: g220a: Fix some gpio (2020-12-11 21:28:02 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.11-devicetree-2

for you to fetch changes up to 5124cff93d99bbfe1efc8deb0c0b3604cb9a6659:

  ARM: dts: aspeed: g220a: Fix some gpio (2020-12-11 21:28:02 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 5.11, round 2

 - New machine

   * Ampere's Mt Jade, an AST2500 BMC for Ampere's Altra reference
     platform

 - Fixes for eMMC, LPC clocking, and misc fixes for the g220a machine

----------------------------------------------------------------
