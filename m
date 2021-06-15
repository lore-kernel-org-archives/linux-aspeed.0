From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 15 Jun 2021 13:16:56 -0700
Subject: [PATCH v2 06/10] mmc: sdhci-of-aspeed: Remove some unnecessary
 casts from KUnit tests
In-Reply-To: <20210513193204.816681-6-davidgow@google.com>
References: <20210513193204.816681-1-davidgow@google.com>
 <20210513193204.816681-6-davidgow@google.com>
Message-ID: <CAFd5g44OdWFTcj5T0e8uPX-HkT3Dm_X3axJV0bza1SE3BvURmg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> With KUnit's EXPECT macros no longer typechecking arguments as strictly,
> get rid of a number of now unnecessary casts.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
