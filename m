From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 6 Mar 2023 10:59:22 +0100
Subject: [PATCH 27/27] kbuild, gpio: gpio-aspeed-sgpio: remove
 MODULE_LICENSE in non-modules
In-Reply-To: <20230222121453.91915-28-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com> <20230222121453.91915-28-nick.alcock@oracle.com>
Message-ID: <CAMRc=Mc76TT+y_OZokRBptgDzA=Tnf6_0BuiBNqB2FRjCEGuHg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 22, 2023 at 1:17?PM Nick Alcock <nick.alcock@oracle.com> wrote:
>
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>

Applied, thanks!

Bart
