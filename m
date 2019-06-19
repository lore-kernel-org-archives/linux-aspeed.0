From: Olof Johansson <olof@lixom.net>
Date: Wed, 19 Jun 2019 07:09:24 -0700
Subject: [PATCH v2] ARM: configs: Remove useless UEVENT_HELPER_PATH
In-Reply-To: <1559636093-26005-1-git-send-email-krzk@kernel.org>
References: <1559636093-26005-1-git-send-email-krzk@kernel.org>
Message-ID: <20190619140924.cl33iuqndoigldgi@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 04, 2019 at 10:14:53AM +0200, Krzysztof Kozlowski wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> 
> Changes since v2:
> 1. Remove unrelated files.
> 2. Add Geert's ack.

So your other patch added mini2440 in a follow-up patch, but this one doesn't?!

Applied with that fixup.


-Olof
