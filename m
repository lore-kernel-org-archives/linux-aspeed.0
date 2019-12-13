From: Dmitry Safonov <dima@arista.com>
Date: Fri, 13 Dec 2019 16:41:53 +0000
Subject: [PATCH 00/58] serial/sysrq: Cleanup ifdeffery
In-Reply-To: <524d9848-28a5-7e65-699b-600c49606487@c-s.fr>
References: <20191213000657.931618-1-dima@arista.com>
 <524d9848-28a5-7e65-699b-600c49606487@c-s.fr>
Message-ID: <0e642e4e-7349-3d92-3e54-cbfd8d417fea@arista.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Christophe,

On 12/13/19 5:47 AM, Christophe Leroy wrote:
> Le 13/12/2019 ? 01:05, Dmitry Safonov a ?crit?:
[..]
> 
> powerpc patchwork didn't get the full series, see
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=148198

Yes, I was under impression that architecture mail-lists want related
patches. But now I see that from the patchwork point of view it's better
to have the whole series in inbox.

> Can't find them on linux-serial patchwork either
> (https://patches.linaro.org/project/linux-serial/list/)

I'm not sure - maybe the frequency of checking is low?
I see all patches in linux-serial ml:
https://marc.info/?l=linux-serial&r=1&b=201912&w=2

> It is impossible to review/test powerpc bits without the first patches
> of the series, where can the entire series be found ?

Sorry for the inconvenience.
I can resend without Cc'ing all people just to ppc mail-list if that
works for you. Or you can clone it directly from my github:
https://github.com/0x7f454c46/linux/tree/sysrq-serial-seq-v1

Thanks,
          Dmitry
