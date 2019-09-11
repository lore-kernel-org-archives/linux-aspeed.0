From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2019 11:13:38 +0100
Subject: [PATCH v3 5/5] gpio: Add in ast2600 details to Aspeed driver
In-Reply-To: <20190906063737.15428-1-rashmica.g@gmail.com>
References: <20190906063737.15428-1-rashmica.g@gmail.com>
Message-ID: <CACRpkdbmusuLNfzcxxnYk=Up7UT3GMdLU4R+WnS86oTV9PNcWw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 6, 2019 at 7:37 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:

> The ast2600 is a new generation of SoC from ASPEED. Similarly to the
> ast2400 and ast2500, it has a GPIO controller for it's 3.3V GPIO pins.
> Additionally, it has a GPIO controller for 1.8V GPIO pins.
>
> As the register names for both controllers are the same and the 36 1.8V
> GPIOs and the first 36 of the 3.3V GPIOs are all bidirectional, we can
> use the same configuration struct and use the ngpio property to
> differentiate between the two sets of GPIOs.
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Patch applied.

Yours,
Linus Walleij
