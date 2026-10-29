Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794D606A31A
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ChxwxZ1H
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFzWJ6z0pz2yQH;
	Fri, 30 Oct 2026 09:32:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1330" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793278846;
	cv=pass; b=KxWXlhHgmzeZHjc56hUCvx6om66dIxAHo+/4V7j95aeCMiCNEsUBa8qOZ4/qwWZK+CnpCC+U5k7R1BnqJdXuj9Qtqfw3bCRiIGewGZ80+a0ZNO1sXZa7jU2H7PivaAZkZQOlHiJ8mp495kP+hoEJG+1bP4QrAIJ1A03UK9VhuEelAL+4C70A1eR2+LfLDWNnsOPJujm5UwdcZYqkgespcavl71kgkit/cyusOh/sqV1JAlON7h8A0R9LaqAZUmE1X6IsooFyRah2xqkKmQ4+K8cbw/Obor3WOYOVptezK+X+wgaFU+6y84UUElrWxaaY1w97OYjUoipc+HUKzGUw2A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793278846; c=relaxed/relaxed;
	bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aY35Xx6RaaeA3U2/gh+4Cpl0KjUNfDPhiG8bCX26DNmglphn7aEAVzcm7RNN9evydQVtmPJJgLLsQQdhGHyCLNsA65Es9weY/LvnRLffFIbhOWmnw7DBzMYUvqzQAyVp9R19evwbxyqEJxDorItjNxXYSKr4zUOkTiYq9JVsO+OXPD0KXQi1NfmoTJvWsOdR+yeowR4n84DjIyOeqe7LQ3jL63pqTOeE+hb0d3Cl0kzSaoHOjVz2XK+2MXhjEQxrC1c7hwp45L65xsrDG+Dt4jf6zPOZC+UpcZx/gmRejYiAzHeEq2YKjC5tvD5ThEGAE3YQ90JHwvEtVLoIiTWCPg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ChxwxZ1H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ChxwxZ1H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFkqd0xJsz2yh4
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:00:44 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-36a10095f3aso279593eec.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Oct 2026 06:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278842; cv=none;
        d=google.com; s=arc-20260327;
        b=EQT35jf8kuUQkgwaDSr7lQrrY9mecIMzGMD8wkID06YOBdF2YLDmK9H9wJf81s7/tE
         yO0l7jZhIswUuxkugXbbcfVfvW+TgGV9QJVCKN47O+7WTd/1w5W4MVQ3aWaLrada9wdC
         Z72cLn2ZauoDXqpBWj2UdKOk6BoXhmxZqe9VOn10yuvWjtekbrW27gBr3NGufb5uKDq3
         Utx45qrA65LK1P9Paa1FWkUwRkS31W1E7V9+D1yG0PvjViI7/S01dLDxi7rTubjrACAi
         kl+UEP9YSk/pL7rmB3/MKmRDKUVYBJttU203ZJp1sdNxtvzs+jnO3Po3qtQPneyUC7b/
         eS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
        fh=AZ3VfmpYWgZpRaZSZjCEXjmPZElemerl755ja3SeKqI=;
        b=atfK8EmSyzyGpEWoDR8fRVbstKC/IW8rzVLdt4bUAR/O65JDHFm9YX9vAAFR7qewFV
         XKRT16LUYjXwmwFrDupTu1gB6Nbp7NiENwj7JmkdyJujL/BsT4bJJcgMPggyvEwgMEXA
         wKmtsN8FB07eUYzn58SbQ3ff8uZL2Lz2pFgkoen2Xo6G6a4HkRulsTrz3NTCwA5PZtD7
         9su5ghhC1aPKVTLVAsgYYsO3dXw0A1K9Qj1/H5yJqATxy7WcmzGnXUluAopL4PaWQ+/q
         pYZbRoaSAuqzrqSmfw/BgifPb4t1kxwMoBV09HS46XL6KMwV+UiXfu1XolCKn+w4liOS
         deww==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793278842; x=1793883642; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
        b=ChxwxZ1H1dyr0Vq8UOG4AHq1Y90h+vcMuHeo6bkVbp5l0f4CEWWF4O0CTmPOFG7bAh
         srBfroXkux2yobfzNDOR8BLVv7jJJgxhHMtoRil5qSEI008O9SKJTEA0jzrzFaaataEf
         WIXVuoPfaVi8qJ6JGB95Jtgrxmlxr0xLvvV5XeNYXmG73K9WgCyOV2rI2DfHoUd0Gl2D
         Om5jqKJ+dJeTvK6xZdnY7URfovoC6GJsLMXNAEtJZM67sFj8CT31eANH4YllxkESL/BQ
         257QWlLfKFOeTBLoVZHRyCTRrlkciKrUt3xb7nB8GFzHsfQd/GHqbFG+9aOkjjNcJXDN
         U6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278842; x=1793883642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
        b=iw7A8OgmUUNqy4IDy4h8LWIwNSQE+3l8zGEOBKrUhTBjSgTzj8e+VR7LThBMOQU6Je
         lQ6khHuy/zxq8XP1AZy6BCpL7xw1GDzXf38EDLyRZtG2VwqkrqW7T4+L4F9F/HZbrB3A
         i1YsOX1amITdo9NJ33Mo4ha71/D8BsHWhUWh+FLxrelJszx8HHvyZcZV2qFyjPxwsvMR
         BB8uoPIEtmrVdth7FFATVttfBCIDvxSal6q9Jkubl08GFljJt9NMAtl/D8azWOPisL4N
         ATYUl1JFh+u+rjS/JZCHydPfkupf2E+x1fesnZa5YjsA6/knHEgcra1kC8upC3AxCIFi
         Ke8A==
X-Forwarded-Encrypted: i=1; AKwUvBx/WR3uVd9rBEpIp2xvs8f/sCYnd9HxKzvbr47PzQEan4SbI7xegNL1up26ZTG6c/3uWb2gCrFdwgOEAJw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLl5G0Rf5oeWigRh+P7rqekscGVbMsmIH8KADv3VwYmidUlmDZ6
	L00yVqXBbpDiMsU9ZbgBKRmKb5m6scMlefs/SMlfI/KjFClFMt6Q+alowXtk/RzD/goOptAv3ZX
	XUi1V2en2LbECHP0/8YcsuUi1+amNhNU=
X-Gm-Gg: AYBFou2iXnCxIIMcPSMm5tMZPh1rY1qJZp/3nXzNr2vEILeCPs81VzTTngQz68fkiAm
	pC1hnfYk4r65oPIz7fBauHLEhgBj6qrYKCdx0sUqSUcRoewhE9wa4wtytjotOj2tI1YbiLbJjfW
	Qf4hXAfqAZU3e4lYRoc5nwzl3pvS/sZGhStYyqsnvh24zc164dl3lZyTuVuet/EUpQ1cKkhfayj
	hp9IjVl23VGJcIxGv3+MoHX2AhYTD5/uuzX844NLZXTLFtiml8wbIgIjnmWNPC/Q9eOi0ok0isH
	ZS4O2duTabC7R/ouI4ZUwJi45bBLfVnMHKeMVGCReeS4QljkrU7WL7T6eadF7D/Eo657k8iRcSn
	TAPbeP/KnAFLeoJAP2UJ88oH0eiyCDOFwpNwLvCivOADxB2aKqmOYa0G+KaXFdrbBIsVt8UCPt4
	//xFlziNIJ5Wo8vXotWenCfA6tvxmPd0jaBy47cHDeSSRKvJzmsFzD/SLcmpqQKEZ4zQG2ZKSlT
	TLtny4LVH/S/IxR+mxa9ucYJdRdpazYTqcOZw==
X-Received: by 2002:a05:693c:4196:20b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36a202cb0e4mr12034617eec.2.1793278841146; Thu, 29 Oct 2026
 06:00:41 -0700 (PDT)
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
 <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
In-Reply-To: <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Oct 2026 14:00:28 +0100
X-Gm-Features: AclHuK_VOCF7u599iESvOsHhN0DoC1VeK-LagvEMwpUC6WNOUUTl411X-macJoc
Message-ID: <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 8:32=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Should gem.h now include <linux/compiler_attributes.h> ?

No, it should be included for you (unless you are doing something
custom with the compiler flags etc.).

I hope that helps!

Cheers,
Miguel

