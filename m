From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 16 Jul 2020 15:16:29 -0700
Subject: [PATCH][next] i2c: aspeed: Use fallthrough pseudo-keyword
In-Reply-To: <20200716215242.GA19193@embeddedor>
References: <20200716215242.GA19193@embeddedor>
Message-ID: <CAFd5g44yqds4xUp=xVbXTpFZydLobfpyLrVdwZOjrRa4=TOj5Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 16, 2020 at 2:47 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1].
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
