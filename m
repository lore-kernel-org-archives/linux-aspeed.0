From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 23 Nov 2021 12:24:41 +0100
Subject: [PATCH/RFC 16/17] ALSA: ice1724: Use bitfield helpers
In-Reply-To: <45fa162856814176045ffbb49ee64cf0ea7e00bc.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <45fa162856814176045ffbb49ee64cf0ea7e00bc.1637592133.git.geert+renesas@glider.be>
Message-ID: <s5hwnkz9ksm.wl-tiwai@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 22 Nov 2021 16:54:09 +0100,
Geert Uytterhoeven wrote:
> 
> Use the field_{get,prep}() helpers, instead of open-coding the same
> operations.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> Marked RFC, as this depends on [PATCH 01/17], but follows a different
> path to upstream.

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
