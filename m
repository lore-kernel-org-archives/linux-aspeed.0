Return-Path: <linux-aspeed+bounces-4677-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA60C5AD55
	for <linux-aspeed@archiver.kernel.org>; Tue, 11 Aug 2026 00:14:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJsYr2phYz2yys;
	Tue, 11 Aug 2026 10:14:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1033" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786355125;
	cv=pass; b=ctzlzhd3fMFR4Gok6bIG4+3UUAcBhwHoFK6famYDEyFWvuRXrIrg0lpOpM1gcyjwC1Iiyko3aCfS0O1UB/+YvGlPpisp/JBoQ+LQ12BfscYq2qBHdoZS1vZUeRk/l9jd1Tt3sR9+ZsAL26GqZIZO0PprB9hJso8TPDHAD5dXZSbbNZyOimHU1XM1YVuMrizx2aD4r4UrSDMw0IWS0B+ZcwR+bgXv934FyN8wRNUuvkgZDgp6+mph4PktAKy0/Yq18KAaKOuqjamJweBHODqiFOhuhRmdwLwx4rh/gdiWd/GuGOQZVU/+FQ7XNL8UeGv5KUcICLs4DiPlHAMRJ4Hdaw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786355125; c=relaxed/relaxed;
	bh=lEhjsMWG90vKMNIv0q/NvqRJMIZC5Z2HAc5jYXUw3Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8p3qHPzVL1JSNs5qZyx/PKYoeJCRbPKRjFlI4KFXxYRiQHfOVy09OleoD2bCUt0qQdGDdQKXW+QkpIkwKQOq6RdraxL2Kw7dsbYCD5lcz/XlSnrFKMA+8drwLXpD8EeVu5oxI8LYf9xk4uuWRwvz0Npin2hdzDfk6KCdP6rpGp30HvmRzsk4B+ifrOCOQmcw0c7b0m5uNxAuT8gbGmHZKT7H5cAL2sQrCaqxDRqnYx2oWRulNqtiVGlVcJmsTg01JZizyH42qHFEvsl3YXDV99x+zFOmRiPSuxRjX6ZSmcNqrxz0l0VcOqnMSZzDD/m3vfnPyKehjH6w9gmDU18BA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V0qVUqPu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V0qVUqPu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJVH74pxWz2yMD
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 19:45:22 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-38e88b60121so1371584a91.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 02:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786355118; cv=none;
        d=google.com; s=arc-20260327;
        b=mxmwOOKVvKJh9geK0YutXYD0eCmSgQ5rO03fEtAsPbCAcasaEQEAnhe+CqHxHr/gg6
         xfIPM5CT2kty9deAQ7x+wm0wcWlLCJG4JZcwQ7kM6OVjR7TIdQGQxUt/qgXofoTxoLba
         8j1MvelirVo7X06DWZzD79RKMvNdOvQU1qWktDybJhiSQR9IYeG3wJEPbQQM1y3W9egi
         VxO1TvJALyVUMROkF3nKo3AFib3ceNpLDQ6SJzERkusuX2k/UXbVBhPc3AZ5zXbaJX4p
         mk+GkjY6FJLiQ3HLJcBMH7gdIush60PEIjm3ZIuLPSMtMAIYqUYa+sDOgfE5GOnbU0Tw
         0Wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lEhjsMWG90vKMNIv0q/NvqRJMIZC5Z2HAc5jYXUw3Vo=;
        fh=ajpoMVDTrhE7Nnj3tVdSsmccUVYR7jaTTbW+uQN72bA=;
        b=iOBdsc8lKznxBWPZ8ssxgxtfdo6dml60So7lUFUsy6rj/I3Tr4EPemCBLqwTmsC3f0
         RrlUaTmuVEzmXACmoudk677Shn5Hm9yq8Erqu0j4VUubl9X8xT3iqu4Tp2Tc49xWlC58
         zY8m7P1oYjI7wR3RCLWjPVK6DHOKa8lv3qsuVRNZgG8xkQRFNzuTqedQgnNVy/oUL36W
         UxtFFi1MTJyI168vwcP1NlSdkFID7Q52IJ1jcInyKMBq7TNd/11u7WEW9mKqk1KPAD8h
         px1Wg4gsujP4/keS4O2Iqntg94Lc3/j004kUVZpuq4eViHUszVnSy6t4UzWcgWK8i7pu
         C2bQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786355118; x=1786959918; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEhjsMWG90vKMNIv0q/NvqRJMIZC5Z2HAc5jYXUw3Vo=;
        b=V0qVUqPuk6Bij7Pw3rBYPrFM27EGTV885/h43Qa4U9Ov5TdoggAcEAJ58MC5qToXFo
         /U0mgaE4lzr8DZ3yVfG2yLmFpytonhLlgBasW77E1YbQkeyrCDd5tE6fIVmJ6A1RVQQV
         DJMADOFMG368fmhzcQN360vaWdQ7BglZPuIdSNHDjyhO8vvJ3aRG60JTaoG1e3gmEkeN
         Lu2QgcPvg9MfTqEe5+Gl9HEyoGbDqBCEKaOrzVCy7Y3okqJMi+lpRCxVqvhYGFvREiB+
         L0jWyFI90jajaTSTWQQvaQMdfXeqs5RjCgqF8p97qBm9OEzsKmwX+oGaddA2wMaJ2BAY
         SxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786355118; x=1786959918;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lEhjsMWG90vKMNIv0q/NvqRJMIZC5Z2HAc5jYXUw3Vo=;
        b=r01+8/JxJfEyq5BhZooYxVZE3667Qky1WPxLBmJC2l9jkqQMnwsk9m0itzETARidWC
         SE5k6fC6KqiDmYiTex0yLtcvGHVAV6NX6rF75MI4TBqftExChJi5aRl5D0K/qu9A1lOL
         StSFAbRehJu7Z7ZS4Du+B9UQvu7UGzq5zUMJ52ef0jmTKx21pQWoe05OBLvi6LmnV9na
         WSspPi+uYuM79dGu7x5aN4JPqwq/JlCsLTQOuN92pDcJ7aeo94pSSKKB4esM01i9uHwH
         4RhgNz1ihAth5xD0a0Se+xV7+XBEkn7d0isjYfFJrNCvYZi952/tGf3SoVoNGHswD30h
         mLiw==
X-Forwarded-Encrypted: i=1; AHgh+RpVyRtNk/SBmO7jjTbQWhJ2AcBnG4R8r6b9XM2+Ssn0S65PAMzi9kXtBQqtdse1eY9TXrPf5tEzfKXgtU4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxrr2lyljlgp+vy9saLhsnSQNNbU8hJi/r8yIBZ3EYZf0Eqn93/
	lDT6X/FlCppBBg09cdL3TAdxYBxo2cLxV/p8Wjvi6KUPHXUiSPiIB/QudpaicfOums5k38RXxuU
	2JMWXea5ziKohpapvDOud4Rx3HCIqq6k=
X-Gm-Gg: AR+sD10vJFAx9puk9I5qABAQkT6YlSpinDRFDndte5BmvSsKSS8QjxB5COYwMBWWBng
	gKYAkbzDi2g2HimViN0R/9NTHmH1uw+GBX/nJkp0YgMqEHn/rv+7VeZgrUtYsPHsrc7G48O5Lbm
	RirwRbLZjcJwNnXCpfyp1LaTj02z0cjYoNhY6E2qvH2zrmjEjzXep2ksHnDuRX7VSEly/gCKiNV
	jNTNSvJ2H2xzhsdNlnStHf/ItP7u/4ql9RJxS3DdqZsqQtpf1FsJf7E7cW7HV6Dz/iZ8tWVs+l/
	0gEAcAuxJrZwzYwAh45j0FoFcmfRP5HJhoHJtbv+Wq8gJ60xGxJiXG1c5qPsUUGuOe+teDlPKtM
	nDKehYowgRYcTJPoJzpefrA7366mEn4FQHKT1RbQnYbRP42QYTw5wK2gi
X-Received: by 2002:a05:6a20:4309:b0:3c4:48da:8102 with SMTP id
 adf61e73a8af0-3cbce930129mr18884836637.29.1786355118398; Mon, 10 Aug 2026
 02:45:18 -0700 (PDT)
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
References: <20260807081652.38692-1-phucduc.bui@gmail.com> <20260807081652.38692-4-phucduc.bui@gmail.com>
 <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net> <CAABR9nFy=GD4afdDxzsbp31Sq=smGVFf+HvqsrJKh_FjqdUrJA@mail.gmail.com>
 <3a9b7b85-e6f8-429a-91df-f674479dee58@roeck-us.net>
In-Reply-To: <3a9b7b85-e6f8-429a-91df-f674479dee58@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 10 Aug 2026 16:45:07 +0700
X-Gm-Features: AUfX_mzy3FMnWBW1ZRsEZF6RiTcGKaOh9JEcD_RNAR4jnG-Nka5rge-6f-tSjWo
Message-ID: <CAABR9nFcitFyS_xZUkreHWp822iVsoEg6ONFwU9JwPaBqm2MTQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,


Thank you for your feedback.

> >>> +                     return irq;
> >>>                if (irq > 0) {
> >>
> >> This if () is no longer needed.
> >>
> >
> > If we remove the if (irq > 0) check, irq can be -ENXIO and would be
> > passed to devm_request_irq().
> > I see that the irq argument of devm_request_irq() is an unsigned int.
> > Would it be safe to pass -ENXIO to it in this case?
> >
> No, sorry, I was wrong.
>

So this means there are no issues with this patch.
Patches 2 and 3 have already been applied by you.
I will temporarily resend only patch 1:
" watchdog: qcom: Propagate errors from optional IRQ lookup "

Best regards,
Phuc

