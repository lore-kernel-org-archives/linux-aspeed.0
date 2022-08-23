From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 23 Aug 2022 13:25:27 +0200
Subject: [PATCH v2 0/2] Fix console probe delay when stdout-path isn't set
In-Reply-To: <20220701012647.2007122-1-saravanak@google.com>
References: <20220701012647.2007122-1-saravanak@google.com>
Message-ID: <YwS5J3effuHQJRZ5@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 30, 2022 at 06:26:38PM -0700, Saravana Kannan wrote:
> These patches are on top of driver-core-next.
> 
> Even if stdout-path isn't set in DT, this patch should take console
> probe times back to how they were before the deferred_probe_timeout
> clean up series[1].

Now dropped from my queue due to lack of a response to other reviewer's
questions.

thanks,

greg k-h
