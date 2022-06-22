From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Jun 2022 12:26:19 +0200
Subject: [PATCH v2 1/2] spi: aspeed: Add pr_debug in aspeed_spi_dirmap_create()
In-Reply-To: <20220622094233.3681843-2-clg@kaod.org>
References: <20220622094233.3681843-1-clg@kaod.org> <20220622094233.3681843-2-clg@kaod.org>
Message-ID: <CAHp75VdBO1yPVH6NCEj8ZSYF2-6q0soE=8qNGrh7G=t7adRBZw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 22, 2022 at 11:46 AM C?dric Le Goater <clg@kaod.org> wrote:
>
> It helps to analyze the default setting of the control register.

Replace "It" with a slightly more descriptive "what is it?".

Also make the subject aligned with the contents of the patch.

-- 
With Best Regards,
Andy Shevchenko
