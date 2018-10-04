From: Joel Stanley <joel@jms.id.au>
Date: Thu, 4 Oct 2018 10:32:17 +0200
Subject: [PATCH i2c-next v5 4/5] i2c: aspeed: Remove hard-coded bus
 timeout value setting
In-Reply-To: <20181003223107.16133-5-jae.hyun.yoo@linux.intel.com>
References: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com>
 <20181003223107.16133-5-jae.hyun.yoo@linux.intel.com>
Message-ID: <CACPK8XdTMfdw1Tu97oD7R7MXQKGHnA5A+SVfAA3RDkiTd_bawA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 4 Oct 2018 at 00:31, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit removes hard-coded bus timeout value setting so that
> it can be set by i2c-core-base.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
