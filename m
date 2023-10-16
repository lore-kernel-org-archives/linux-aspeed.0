From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Oct 2023 12:19:21 +1030
Subject: [GIT PULL] ARM: aspeed: soc changes for 6.7
Message-ID: <CACPK8XcTx9bd7DkguFOZ4qCxk8MJWm-yeNMLGDCnO+wv7dwa1g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello soc maintainers,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git tags/aspeed-6.7-soc

for you to fetch changes up to 0af9e89106c359e531791c3dc2422a16bd40d17f:

  soc/aspeed: Convert to platform remove callback returning void
(2023-10-13 15:04:12 +1030)

----------------------------------------------------------------
ASPEED soc updates for 6.7

 * Move all drivers to .remove_new callback

----------------------------------------------------------------
Uwe Kleine-K?nig (1):
      soc/aspeed: Convert to platform remove callback returning void

 drivers/soc/aspeed/aspeed-lpc-ctrl.c     | 6 ++----
 drivers/soc/aspeed/aspeed-lpc-snoop.c    | 6 ++----
 drivers/soc/aspeed/aspeed-p2a-ctrl.c     | 6 ++----
 drivers/soc/aspeed/aspeed-uart-routing.c | 6 ++----
 4 files changed, 8 insertions(+), 16 deletions(-)
