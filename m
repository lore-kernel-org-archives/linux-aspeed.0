From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 13 Apr 2021 14:24:04 -0700
Subject: [PATCH v4 3/4] i2c: aspeed: add buffer mode transfer support
In-Reply-To: <20210224191720.7724-4-jae.hyun.yoo@linux.intel.com>
References: <20210224191720.7724-1-jae.hyun.yoo@linux.intel.com>
 <20210224191720.7724-4-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAFd5g452cbyy0Cu=z952X_WMNUoh5TtHvUpDQpA4-APodxZnpQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 24, 2021 at 11:04 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This driver uses byte mode that makes lots of interrupt calls
> which isn't good for performance and it makes the driver very
> timing sensitive. To improve performance of the driver, this commit
> adds buffer mode transfer support which uses I2C SRAM buffer
> instead of using a single byte buffer.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Tested-by: Tao Ren <taoren@fb.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
