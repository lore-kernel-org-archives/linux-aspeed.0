From: Joel Stanley <joel@jms.id.au>
Date: Wed, 10 Feb 2021 12:30:27 +0000
Subject: [GIT PULL] ARM: aspeed: soc changes for 5.12
Message-ID: <CACPK8Xf+4VkWC6rkHhsWdwhaLjy2Az=GAHaEe=SvOiUc_OGKSQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

A small pull request for the aspeed platform this time around.

The following changes since commit d0e72be77e7995923fac73f27cf7a75d3d1a4dec:

  soc: aspeed: socinfo: Add new systems (2021-02-10 22:25:45 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.12-soc

for you to fetch changes up to d0e72be77e7995923fac73f27cf7a75d3d1a4dec:

  soc: aspeed: socinfo: Add new systems (2021-02-10 22:25:45 +1030)

----------------------------------------------------------------
ASPEED soc driver updates for 5.12

 - Clock control logic for LPC snoop driver
 - New system ids for AST2600 variants

----------------------------------------------------------------
Jae Hyun Yoo (1):
      soc: aspeed: snoop: Add clock control logic

Joel Stanley (1):
      soc: aspeed: socinfo: Add new systems
