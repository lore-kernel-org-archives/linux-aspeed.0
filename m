Return-Path: <linux-aspeed+bounces-5126-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC509CA5FCE
	for <linux-aspeed@archiver.kernel.org>; Sun,  4 Oct 2026 10:19:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyJQj5Xyjz30St;
	Sun, 04 Oct 2026 21:19:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::112b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791109149;
	cv=pass; b=ba/vx3KUlbr/BX7gyvvj0nCfn8moDpGWs0Ys3UnLJhR/ThUmaCSpcXXdAJETsHXPsk0z8bJQpRDwBFiBwGujCBIqMBClHQnt1vVf7tfdKwpaXxOfTWsweBky+pWUx0sOpIP91pX3nuomMlXJE3scdaAFPic7A2CmpYl3ywDMPZINnT8j66M8AznUiE3eZ3I90b5WEdsDi8yKrOg3oJrUiqaU/N0+rJqWuEl9ja77vURkG6l1LQwRf9wblOMu1gjMFejB2FeAMEILNaXfE7Y+h15DkLxY37Jwb0HwziePv8Fh0vmJQqJkVtTiWPAAzPP148dVC4r57xJKhKrX+mB0dA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791109149; c=relaxed/relaxed;
	bh=FHDLRTWsqm1v2sDVxXhUANWcv5ddv3GsR8vXFn0sF4o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Jo7EdgpMxuY93pgmkg3oEXi+fQoUxrtL/nvFp5F7uhrtGvsHMlOO9O8O0oAJRZjA7msyWWlP9Y9fnKcH2mN6/RH4bYlTXN8EOWJ6+ilhg6R8lkGHFzrPP74fTSa2cW5i8NneEuSmHHoRdgLFCIHSacTSmHXedYBwvG2dMQUYmsm7im0T5bbiX03DceqND828UwWHEXBh9pxJpY5DTZDDKYsndlyEzxxb8BsrcW/pGbyK0yQhliStxmn3PB7Zy9Ub/s7NuBTs0NwUgko599zfyxfgTBJS/ao3hhfwypFzlYG0XwYgavNLr3DkpSXviFSXpvPZTHDf+Nyq4StQeIyALQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GBAXvGok; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GBAXvGok;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyJQf5WZHz2yf9
	for <linux-aspeed@lists.ozlabs.org>; Sun, 04 Oct 2026 21:19:05 +1100 (AEDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-8ac9d666d4eso7151377b3.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 04 Oct 2026 03:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791109137; cv=none;
        d=google.com; s=arc-20260327;
        b=R8iAcaoaLnik4tAau3XhxpT3NlhgnkyMSpHeu8t174tCbtyQ5ldtwNm5iEBIdjfrj6
         jpHiVAEBAwOZlqH+S+VX89odQyFKMnAV2HPU3N4sVV0nwOVYiZnk+YterFDOnoOicpxn
         dbKkECEMWpflKaTQHmSIx1CUopvstut+ZrCqmA59yUHkayF5KuQ/HUZE34Qj9jMB6nOT
         QKhqRc/3JHvvpm4AAHQEN94Bma0rghz8UuPQ1xxxoWIfhbNqC9rPl20NvOKqm8j6hJYo
         aE6rgeiPxg5RtGRV0C9z8mMrdMXj5IRgkhtXR/09Mx1k4PAw1a9v3Nvov9LrGHytaJhk
         r16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FHDLRTWsqm1v2sDVxXhUANWcv5ddv3GsR8vXFn0sF4o=;
        fh=TPMxuPFlXCogfoXf6gQjBZHS2yoHp/IUrYU+F7ENkxw=;
        b=dyYbqr8w8skojnMFn7eE0JIoLJu/+zF8A/0AS81epQbsjdBum7tp0hbiLWt147nAwT
         uR1I3yd1XS8BURGx8kJCccu1Mho2Kfu7gXkKR4vspxi83hvXN74Y51VUODTsN+IqBzdP
         c+/XeAG+IcCTKoRctOylWx53wIUdzYN0xCdAyCrmbd5QM0nlLLxssaBHvp898qW7w/fB
         7Bf9uGJ1GpZX9G6/FriEC0E4CaAb5eBxfGggOQBKipHJ337zhnPgc323xG2oT02CvHeq
         palGOQkP43AGemqxjPxAoe+nMMF1fB2PslosyNHIJblGpKu0KCiW4HXYoehlh+P16s2S
         IXvw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791109137; x=1791713937; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHDLRTWsqm1v2sDVxXhUANWcv5ddv3GsR8vXFn0sF4o=;
        b=GBAXvGok3T6AQHxzvN0GGq+4sj388E5uWrCOs3cJJWYaa1NMgkRgZizCOJSUm0vKcQ
         O3c38AQsz26gYf3/8Iz5jOaqMmpoOLLHRgSjp64R9tvpng2hSUbKr2/NTpYEXzKeHK7p
         lX2eZdSrmzUYZ9wp9wFP/IWaZU+N/C9oMqcmZATTw/czbY2NFBZ7RAbqhhhftYxe81eW
         yg4VoU/2pl9FdOWPMeyo8ECQKfv1Muu7JQpuepK9I5lLeUvRWyhJJTzh/i40KtruAfiK
         t5PYrVjNa13YeVBoh3zt8HfnTHaNBFcI9kyXI0bn7a5cTd67cq1gyAUehqjW4UOpeDiI
         GZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791109137; x=1791713937;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FHDLRTWsqm1v2sDVxXhUANWcv5ddv3GsR8vXFn0sF4o=;
        b=ObMCC4aalP+FPcWQux5A1aGcg0iqU20O6HUN/gqvMIA6wdHObVEP7rNNZGBuqban3F
         CqCOA51izeZOCxypBHYBkNRpvqxX7MFUdNsRTbOSN1AYilfvbEyvUThshaTVR1jrzDuY
         U5OU96JooP8kD0H2OxkIZwPYqP2RxCrH4XoaySOQ1WizaM9dgUFKMO+/nzT8Ub2+2bi/
         hG8fhyVFOoRs3dPOGDCQqIpM+R5UInJ805aBpQy9uAnucWATV1xEngpyArEpLU/LapQ7
         I6zdQLVbMwfg0OGyTrL0wk9cvsQLTXzlbSM77gtJxj4m0g6/GxoOMpWmqDdUKrjGpAIS
         jiUg==
X-Gm-Message-State: AFq9FYJcPqaNf3O57pYXMlBNVwB9WIpwc9lBcOx5sd7li9SQk6oK4mp8
	M5yngMsYX0JWYe2QR935VGCyVofIqQelDvzTT/mM8sMTzXIAC6cMAjAjI+PEQzeJO7peyimYKtN
	Z07TdQG+nE7CDRDfIOcO9EbNkJ3RccT8=
X-Gm-Gg: AYBFou2ysgzOwZYV0chDF40rNtzTe9ZEe+BuqC4MMnl50FYepQG0xRvqKI6VtKQmTN7
	KvzoEP5wdsCXyJDjfi8TePAbSW+YQPrlxekrAuE2UuoY0l5qatXcoa4eLCzCsWxKXXq0cWCBqEb
	R2HU7EhKzmJO0Z8Ufs4ETdS3wN0bDlDZG8Jhx643tieBqJF/ErasQRJST50amP2wrYLrRWsxWhc
	a9E/pn7IgTJ3t4JH0zZZRfAzRkeFcfxUaxFrEE7fPTEPFbXqD+qtaNYq6mIWyrV+rXZXv7UI/yo
	RJB45j94p5hMVFCdbEaKmD1nk5k6++F7oGNTezMIrXqwqR7ch4ytDY9TacNj3TtZDwWA
X-Received: by 2002:a05:690c:e285:b0:8ac:805b:3a6e with SMTP id
 00721157ae682-8ae94ca3034mr9201637b3.25.1791109137685; Sun, 04 Oct 2026
 03:18:57 -0700 (PDT)
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Sun, 4 Oct 2026 15:48:46 +0530
X-Gm-Features: AclHuK8uC53IfbueYoLt9cYxf1WxTPbz_S-0lUvFuzF6RUcIgmXBS_Cylz29aks
Message-ID: <CAMFFDGh6XwYD-axu3brX0Tdt3PteJHHGo6oJaghzpvnEyzT58g@mail.gmail.com>
Subject: [RFC QUESTION] AST2600 GPIOP2/GPIOP3 pass-through with gpiolib ownership
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I am investigating host power control on the ASRock Rack B650D4U,
which uses AST2600 GPIOP3 (GPIO123) as the host power output.

Vendor firmware enables SCU4BC bits 27:26 (the existing THRU1
function) around the host power pulse:

  SCU4BC: 0x02000000 -> 0x0e000000
  changed bits: 27:26
  GPIO123: high -> short low pulse -> high

The upstream THRU1 pinctrl group claims GPIOP2/P3, so selecting it
statically prevents x86-power-control from requesting GPIO122/123.
Without THRU1, x86-power-control can pulse GPIO123, but the host power
circuit does not respond.

What is the preferred upstream representation for an AST2600
GPIO pass-through pair that must remain controllable through gpiolib?
Would a generic Aspeed pinctrl/GPIO extension be appropriate, with a
documented DT property identifying the pass-through pair?

I am not proposing a board-specific sysfs interface or direct userspace
SCU register access. I would appreciate guidance on the correct kernel
ownership and pinctrl model before preparing an implementation.

Regards,
Prasanth Kumar Padarthi

