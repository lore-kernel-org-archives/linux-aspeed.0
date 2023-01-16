From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jan 2023 13:37:31 -0500
Subject: [PATCH 00/22] drm: Remove includes for drm_crtc_helper.h
In-Reply-To: <87k01me9jn.fsf@intel.com>
References: <20230116131235.18917-1-tzimmermann@suse.de> <87k01me9jn.fsf@intel.com>
Message-ID: <CADnq5_PsL8N27_LC_h1m8i_FCg6mJtr7K9Yjv=guw-KGD2wU5w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 16, 2023 at 11:20 AM Jani Nikula
<jani.nikula@linux.intel.com> wrote:
>
> On Mon, 16 Jan 2023, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > A lot of source files include drm_crtc_helper.h for its contained
> > include statements. This leads to excessive compile-time dependencies.
> >
> > Where possible, remove the include statements for drm_crtc_helper.h
> > and include the required source files directly. Also remove the
> > include statements from drm_crtc_helper.h itself, which doesn't need
> > most of them.
> >
> > I built this patchset on x86-64, aarch64 and arm. Hopefully I found
> > all include dependencies.
>
> I think this is the right direction and I support this. Personally I
> think it's enough to build test and fix any fallout afterwards.
>
> To that end, I did build test this myself with my config, and it was
> fine, though that probably doesn't add much coverage.
>
> FWIW,
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>

Agreed.  I applied 1/22 since it was an unrelated cleanup, but the
rest of the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
>
> --
> Jani Nikula, Intel Open Source Graphics Center
