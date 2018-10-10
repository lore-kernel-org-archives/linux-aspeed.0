From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 9 Oct 2018 17:00:48 -0700
Subject: [PATCH i2c-next v7 4/5] i2c: aspeed: Remove hard-coded bus
 timeout value setting
In-Reply-To: <20181005214507.26315-5-jae.hyun.yoo@linux.intel.com>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com>
 <20181005214507.26315-5-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAFd5g44vi55oMkif1K+hx=O_J0_jqeQunRNiDARF0=qJ=54jiw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 5, 2018 at 2:45 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit removes hard-coded bus timeout value setting so that
> it can be set by i2c-core-base.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
