From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 17 Jun 2019 18:56:06 +0100
Subject: [PATCH 06/59] drm/prime: Actually remove DRIVER_PRIME everywhere
In-Reply-To: <20190614203615.12639-7-daniel.vetter@ffwll.ch>
References: <20190614203615.12639-1-daniel.vetter@ffwll.ch>
 <20190614203615.12639-7-daniel.vetter@ffwll.ch>
Message-ID: <20190617175606.GE26766@arch-x1c3>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2019/06/14, Daniel Vetter wrote:
> Split out to make the functional changes stick out more.
> 
Since this patch flew-by, as standalone one (intentionally or not) I'd
add, anything vaguely like:

"Core users of DRIVER_PRIME were removed from core with prior patches."

HTH
Emil
