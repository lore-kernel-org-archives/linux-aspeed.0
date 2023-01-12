From: Kees Cook <keescook@chromium.org>
Date: Thu, 12 Jan 2023 14:17:36 -0800
Subject: [PATCH][next] crypto: aspeed - Replace zero-length array with
 flexible-array member
In-Reply-To: <Y7zBxbEAvcEEJRie@work>
References: <Y7zBxbEAvcEEJRie@work>
Message-ID: <202301121417.EE86BDD5C@keescook>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 09, 2023 at 07:39:17PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> array declaration in struct aspeed_sham_ctx with flex-array
> member.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
