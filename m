From: Joel Stanley <joel@jms.id.au>
Date: Sat, 22 Jun 2019 07:59:26 +0000
Subject: [GIT PULL] ARM: aspeed: soc changes for 5.3
Message-ID: <CACPK8Xdpd3Q7dexOEZqt9rP0KJz1XeRwXe6A1k1azm7eDhRm=g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi ARM maintainers,

Here is a small soc change and a fix for that same change. This is the
first time I've had an aspeed soc pull request, so here we go.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
    tags/aspeed-5.3-soc

for you to fetch changes up to c8a3b9b50d8331528fc8d03aadd1fec3d60362d7:

  soc: aspeed: lpc-ctrl: Fix probe error handling (2019-06-22 16:56:35 +0930)

----------------------------------------------------------------
ASPEED SoC updates for 5.3

LPC control driver changes and a fix.

----------------------------------------------------------------
Joel Stanley (1):
      soc: aspeed: lpc-ctrl: Fix probe error handling

Vijay Khemka (1):
      soc: aspeed: lpc-ctrl: make parameter optional

 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 61 ++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 23 deletions(-)
