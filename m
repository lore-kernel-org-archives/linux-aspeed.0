From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Dec 2021 04:29:15 +0100
Subject: [PATCH v1] pinctrl: aspeed: fix unmet dependencies on MFD_SYSCON
 for PINCTRL_ASPEED
In-Reply-To: <20211215214022.146391-1-julianbraha@gmail.com>
References: <20211215214022.146391-1-julianbraha@gmail.com>
Message-ID: <CACRpkdYngi90omV64yj4OEQysKhVVaOpwXAThUtv51Rv9NvxNw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 15, 2021 at 10:40 PM Julian Braha <julianbraha@gmail.com> wrote:

> When PINCTRL_ASPEED_G* is selected,
> and MFD_SYSCON is not selected,
> Kbuild gives the following warnings:

Patch applied as nonurgent fix.

Yours,
Linus Walleij
