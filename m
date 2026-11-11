Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CEE606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yclevY1d
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPX9d3Fycz2xWR;
	Wed, 11 Nov 2026 16:28:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::22b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794374901;
	cv=pass; b=mFtETOK/Rb6czcXB3XkscGhwBrEVkEtsiw0MrdyEc9Ofoj3ZKh9fiWVrW8Bq1UiKQJUlIMKZeAtGZ/7S9yDwTymKG5GcuIE5aTZFb1P2qiqqEnjL7xQvs9+v4IW9+yXI2HXZCKJ9tswuJW3TBMmzPPkBk2rH9V95RbbGJgMz1Ga0bUpwtrvkq3+L5MizcUQC/ghu9yuY9TIZgSspWNqCFxEZUF1kHflIc6JlAI3iqzZc6D+kAjXtFXkCAETsTKuOWFAhHoSaguK6BNAmVhRBidc33/v4aENUivlW19U99IbJPr7ykCeWCDbcS++eB02p7hJVF4TveR777YFVy9NWKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794374901; c=relaxed/relaxed;
	bh=hUPfJWrPKXadZ6OdI2hx5l6Gvu+kVXSB9AVbCboiOB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXH/42M1EcifuReoKkVo3SqUgH83C5acCDqRlj4vQMCeEIkYZt0zeIGoL9inagEJmWf3rHUBFN/XQr0ykLzvknD4wQEaJSMzJKySmYHlUJuduIk0TiyGHyO0pbefckOPhvAdLhFVkpnemNtc0A6jcUGyUg3ijsDU63pUaLZvJ8G3zqDWoxze7yOTE8a/KVmOPWH8eX3VfBT+8sTiUqM5r0bdJuDeBYSsc/QaRxxe+eGM165JlE+u5wFSoAwAMWvBCcK5tIoC8CkAmez01CIvSHAkJV0GAqCyq5h2QScTEd1tEjv2fUQ32sgVxOj+h0Ov9S4I+v7r8tWUnxCajGTtjw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yclevY1d; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yclevY1d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPX9b4rKqz2xHP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 16:28:18 +1100 (AEDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-3ae0eb56ba1so11039011fa.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 21:28:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794374894; cv=none;
        d=google.com; s=arc-20260327;
        b=heX9e9iaV7kczGrPnw/qIZOsI2u3fFgq9FZYWpgo5XSHl3ToTvnVQjEYXQP9csRXYm
         5+ktC5TO5eQkgMeFH0+kt3TO/zUFTjubE2tM3wFcRqUenhdzteZbq9lfxz98NScRCXzv
         tu9zIZiPXQIafpZxsP1/GPOabGclQzcAzV80SPas0DzPSGPfWJrXHAzesNgR2OQcHgwZ
         p6Ayrn3GUDTu2dEsP4UplSYeP4lFKXlGFeWIvCkqbybwdbDgp7G/uQp4CCU7EE8hejDX
         q+JXg9h4P3wDYs072L3f4Br/BZBqRx0LznoEeKfmzZ1VDra3E3wDN/ttGcMx+ztv+ZYq
         kK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hUPfJWrPKXadZ6OdI2hx5l6Gvu+kVXSB9AVbCboiOB4=;
        fh=S3WqsnQHq3czv2SSBFWuinfhJz5Ni5Lt6EbQyLPQNyg=;
        b=JIUjYgPLoMIvR0VHIKGdDHv2vQ4MO+Sn9imnxfCFYodmEwG53QCwbgfcfwJLEmCRZB
         krYJWN5NTSXXsN+1SUxr7lN+5ndD8sU4mBw7r3TM00XrihRLk6iijMNHnIU6dtqbp1XM
         2sthc7a1wimRjFqboV/TwjKyO9Yhp3jEh0awAD3a9ooNaKjyCAnQbjrmC4wHcTB5aigu
         6d38NWAdyfGYx5R6O2Mv8rC9X6vH0BQJ3EuaUcyqUKlL+LsybNlmZhRKWMO5u9wv88Ny
         82Tsk0U/3bDOaVcH1tLDOJLUmwhwMCU9vvF/jiRbpJJtiABiAvAmDuHXIOd9l7vvsAHN
         Sf8g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374894; x=1794979694; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hUPfJWrPKXadZ6OdI2hx5l6Gvu+kVXSB9AVbCboiOB4=;
        b=yclevY1dcE6V05Gj8ZG/UFgF8KMdxD8wgTtqSqytEi5lRlcd6vCiwigLVMPgG3tcKE
         FIbt0kNUUtasX/VKqw3wlkPdsTQ3/lS0Ol6++caUOn6XpSrKXWYNmi2vH5wgzDU8JgPY
         xBC13kmGJP/ysPLQEb+VZVTMrk0xukLky9XA/iZnXVU79BkDQ4yGGkpCWh+G5Q4BKhuF
         FJviZND9mBreT1itUJffc55YPfuqWAnzwz8wdjqRTyBSgD8GxcJkMbnyhJCH8xzGK9eV
         I7VNib3D2QLTtVHZlYzLVKohc4w0S3/jFSV2Goh32NbAGzXJ/x/tAvm1nOL/fYNk53PH
         iTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374894; x=1794979694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hUPfJWrPKXadZ6OdI2hx5l6Gvu+kVXSB9AVbCboiOB4=;
        b=BqZ6EVN51CK4xL+e13GRagccWl2NgUNXhSPqo7JB+mWtdqAAw4uX0dKlNwhtPOtPkg
         Q1e3419ZdI8/QajC/svm29a/lHh66yv+KBij/T7OOuNhz9Dk2KIzDARhCcaQeL0PC6Ah
         cyYUoxweBSbS5ZT4mKMXRQUzS89BeXvmEt1JOjrOaI0SvZj8hJNYGFG/Aok3auqf2qU3
         StQtbwlaA3I+BzBqr4JOCXW4MpzG0SGcw2Kuoeo3t7mK3mB+efEbMZLSXL9/37KZbZpZ
         uupc701BtfPlpjH+9mKdXVWuWzPnYz/bSglFbouVvelxVRAWrU4f/qzz56DSrEgaxwAB
         e8rQ==
X-Forwarded-Encrypted: i=1; AL+hErF7iB6QpdK4Xo5H4I9JFpYMpLBoh6iq0i9yNQuF685txAd23IVR26oRbsmZYWcv1Xs3jJbre0u3StYTKfs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/+5FpnnxUuvmtrb8sahECHq4lLwnxefqu8V4aK7SFdRdY52mhe
	tqySiFfu2hCk5y9sJvse3lROMeCFEoLulCWraHuKFlPR3MOANjK0zauQ4em+j/gGddfhvKa3ZGh
	tXrNJfT3bXnDmB1z6yklBU2nIyrd2thI=
X-Gm-Gg: AYBFou2sK5VHFXT1mU3jjdEOF4fLr/TLCYfFq0VTYurZiLmyxWCzdKWYMbQRayVNE+6
	WqPENITb/hHvgwnEZ32CAqxh25mutB7Y9eg/qjk/jL2cHYc056bDTbdrvbm5JJMXB9FglFMI3QK
	x+xFNGZVENzScu7U/El8kpPal83GMJ0i0NgJdrPiHfszYTcFqaW/XUzLwCuEl0a9aX9YvMPOqxZ
	hOPZ4F6zU0rVvYrQcthXSWB6XJmvowHZnFuR7s+SCubrM4A/ua3lhflHDwK7ZY7SjrqZ1+ubNUe
	//8UPKvIuSoZwaSLq3/ft0l4rStqyRlYsEFZBom5E6FgUeq1/B7Ir0bAJ5cuM/zkMpsEe8FHyC6
	R8kcoj8sqHjKFzJY98pUZZXrMsQ66JN+79KyY9g==
X-Received: by 2002:a05:651c:885:b0:3ab:3af4:c2d8 with SMTP id
 38308e7fff4ca-3ae126de2dfmr1890061fa.28.1794374894004; Tue, 10 Nov 2026
 21:28:14 -0800 (PST)
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
References: <20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com>
 <245d0e9d4043c0957716a6a32985b6ea5a8cb9ef.camel@codeconstruct.com.au>
 <CAF7HswPYb3hOWA7P-d1zASvd1XzaVeuBkoqz5nXHuDeEAXDhrA@mail.gmail.com> <cb3d9f50467089c6b13ea83aeddfb032c046848a.camel@codeconstruct.com.au>
In-Reply-To: <cb3d9f50467089c6b13ea83aeddfb032c046848a.camel@codeconstruct.com.au>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 11 Nov 2026 13:32:41 +0800
X-Gm-Features: AclHuK9X5Dqhm5-z10kEg9eblLbAlNWS5sD8otV-cBTsQml1KPQHVi6FoGfBKpQ
Message-ID: <CAF7HswNubLB9ZJRsJge5_YEGY4xZJCWaLA9k+My_8HcmC4fRzQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: ventura2: Add LTC2305 ADCs and GPIO
 line names
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 9:21=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
> Thanks. Can you please let me know when this one has merged?

Yes, I will do. It was only posted yesterday and is still waiting for revie=
w.
I'll follow up once it has been applied, and send v2 with the reworked
cover letter at that point.

Kyle Hsieh

