From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 02 Jul 2024 08:57:25 -0000
Subject: [PATCH 9/9] eeprom: at24: remove deprecated Kconfig symbol
In-Reply-To: <20240701-b4-v6-10-topic-usbc-tcpci-v1-9-3fd5f4a193cc@pengutronix.de>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
 <20240701-b4-v6-10-topic-usbc-tcpci-v1-9-3fd5f4a193cc@pengutronix.de>
Message-ID: <CAMRc=McP=K0jSD56JdCR9DPJmJN39Z74mjAo0qX2mEnTBN1GAA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 1, 2024 at 3:54?PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> All kernel users are shifted to the new MTD_EEPROM_AT24 Kconfig symbol
> so we can drop the old one.
>

Nope, with this series arm64 still selects the old symbol.

Bart
