Return-Path: <linux-aspeed+bounces-4660-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29530C5AD2C
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 02:50:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHj6f1YG8z2xd2;
	Sun, 09 Aug 2026 12:50:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::42e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786179617;
	cv=pass; b=Pu+bh6vGO6BDTQ4OZSYFrjQyRHgsmb6dXfow3cl2Y3DG907btMREfFt9MbZI2ZLS6HintDpbLz6LBvcYv5wOUNQJ12949GnTYLhLknOIXmkcBQVVo7aqaeOzJHRJusmWM3wLPPRcNgr2CdieH1MIUsOWhUfpRW3xw8DDQtm2fM7iJog67B5u6qB1ofB74I4qWRAp6LplAx17yKES5zF2vOvkWizOM9yI1/XD/FjM0UfTKIZhGc4kvihRBfD03PsXIj1sBKJxO88ZtkA/6pQMSfFXJryeSUyDXPjY+4pDGxFzWJyFp3HC98lMnhBBrWuEZB0MbClQ+GJegEEGMRwZ+A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786179617; c=relaxed/relaxed;
	bh=Ttb+o5p7BZaAI5tLlxIO8Vba8Yks4awltsT919HRAqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9nCVlA3G332HEN6fSL+bryDC+feKVRqiaCPthuIqXcZPtk0yHfgwQ+Gau3zVTFGBQqdG2MXQsfORRiUpiJV2QjFBD8ALIO1H6aG9i0UL1R8sli9V+5rDJQr9MKkl9B5kIZniHxpvKSxN77FzYnjGGmh78ygOBz+1j3ZPtksAl7XaAHhIGf9zyOv4eMrAnDoVIRgp9iphBimBGRgwwBmN5C8bYFDzaEcja4SWWVgm6cBpGZdkyJawmgWSykMw1bXR8VNsiJryJKwyEBkn5eTepNjzWE2h/uQJa4KDWdVA+/nB1F0eBLENKtUVOkn3UoMi5mHuCIC5sjHp8GdZ9fG8Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FWYHlWGK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FWYHlWGK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHFMy6W3Yz2xjN
	for <linux-aspeed@lists.ozlabs.org>; Sat, 08 Aug 2026 19:00:13 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-84a2c90e383so2197660b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 08 Aug 2026 02:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786179610; cv=none;
        d=google.com; s=arc-20260327;
        b=FXFsOSFhovOB+dpHc8havQXen4hqONp5SqnoYsyekyEvHaCMannR2H3dCJ3EQH4ZvY
         cL1sSx4UFc/EpwCapvkUuqJmmXcF08qvKK7hLm6q/8zuNuCjKPE80dHA2BQeHR23f8dN
         bknNFbW+HEcvPU4ALwmJ6y+jKY+DYzC8eimXi1IgtpPxnuhlojA0BDBDvXebom3Ebaf4
         UDhDudtiimrSM8iKlbWl+Oq3OgRaBym29KTjAy+3TeS1J5bX7jQErR+WXr3iU6ljDV8F
         cD96XdACyftQE0i7Hn1qSyBNMXMdhKE5+/jldwiMMABistMx5VNybJbOSw3RNpWcWhCb
         DDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ttb+o5p7BZaAI5tLlxIO8Vba8Yks4awltsT919HRAqY=;
        fh=8cYrDvYC3IpFTE7VElQxUfNO1SFBJXAhEqEg5FluJ38=;
        b=aUOZm2NlwGRz7WWCXNvG6K//sIGDCSrVQEVZeRQmE5jpKKZKHi+rnKO9nt/oK6d9RW
         MaWkqEwyDg15ojyRsJwz3wqk4wjFrlY9+Jyu9svjW6HelxE6K5m93+iqf5eyFWcD08qj
         mMJfS4ZXW2b0bgeXqy3ix5QnWlVuaGaGfHvFw744p4PMuLHrXqB9SpKjxYAQIbOhrdWa
         1MlKcPTDuR8P+4twzvsuQ3ZDzeR9+LE99VoWZNtNBJ6+cLPARZtp1tTytxXwdqHDt2Ek
         BVBhkDk27Hn8s95AoWsTeRF1FhJOfegl4NzezpC5TuyW9M0Hg74bZahIhh8dN5JmgKF/
         Xq8A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786179610; x=1786784410; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ttb+o5p7BZaAI5tLlxIO8Vba8Yks4awltsT919HRAqY=;
        b=FWYHlWGK45dIqPoEeQ16hdmN2hkvVPOZXXe7DQKV0arkSC6pVFPtojGMIyL1j/24B2
         0jWsLy08J4vBupMj2C3Klbr1Iw9aYIZD9Br0kdVeEsWaVVnQHy/CEKAwM2vw2eX3YXv4
         Vdywp6KkiaV7lTZxVONKDSiVtauX5TT2LqChDCgr3K8XV2YdFong4BH7m+VaWUaFWZkG
         5wbAP8SQrkKuKpFuA+A66vTETgjLIAYn0s4480/x0zYlAkC9CsbXkThLviY3Tw3eJJFK
         UoUKCBg2eY2NmjYnyoRmwFkOGEUliZFvf3J9jnvnfbRoJcBPwrr/YUPKM/r8VXXqGeCT
         YUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786179610; x=1786784410;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ttb+o5p7BZaAI5tLlxIO8Vba8Yks4awltsT919HRAqY=;
        b=Vd/dTfXCbQtPbuU4u88Dq2t1F2vSVc5PifW9qweP3reTW28AOJ2BuFB0dm+6adL4BH
         AP/KH1hD6mAKuekEsd8y1Uv5ddytpGSVIt4cvXgvpkY72b2jsO2O/x5BxNA5W/axKlT/
         4JFuUkt4Ed5nDS0Rd3LZIo/WJ/+xUKGgUjWlO46qNME961gapyCILVsIYbGoorgORS9Q
         b6uUTH2uj2a6sSmxep/2NH0DcQfdeBt/BYgUHq4GhaJK9SDt64+Gh/sLOhmXnjcYFwvU
         IFmw3c9cOl7IDKtm6SrNt4vf1iX9uE5c0uF5wmL6Gp4LwiJd4KkwaiAOzS+g7+MHo/+J
         6N1w==
X-Forwarded-Encrypted: i=1; AHgh+RrEHARrcSkIkTtuYuIwb/8kxbStKkSxyu5TnCq4QNaHi0/NKer47ey67sNc7EIHD25bOGszOkH+li9RqSk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbL/Vll/Gawq0sJiN96HDmkAl+bRY3McAadwcrVdJEs/93C3RJ
	52nhjfJ9Hm8uZSykb8MFIFZoaC7zr+uGzaK+qV1kzBMa6Xv1kN6v1JlBV0J0MK1p5/diodTiZ1U
	AIbgWxZzC046euAc5J3JFqARNBl+n5kw=
X-Gm-Gg: AR+sD11RZibEYhwKtP+KqX24jR05jMtzAjhSSMQy9oJ0MGKrvVmk21r1Qo9jS5+R+/O
	/VdxsUlWtIVPKLMIshHzTA/suqQumB+5nVhaWdyPHHAXItpqzuOs00q4dffUeuCTPuP72V9u1yl
	pVMCXVJwWjaO4mcmVSQXWC55UJ2/tImL6h7vAwfnQm6LieUCSWKiFpYjXqWsD/3XV91yGbAiCoV
	jYdVJxtYOBuBWTLJw3OtE41ndz/yIC+m6RY+bZ0XuEUpp6nCphJnB4FCYLRb39f813feZTiNp6X
	ey/Kqih23D+To4Dm7s73iSufMprqxy09UmP01pFQg+It2WS07v5Je3yo3CsfElMtus7MbBanqCF
	cxgieqmZi6VwF9WYYOteacOrSL6Zf8jEqQMYzIWIxjnPVvksq+YDozZXb8EepPpn85F8RALuYQv
	fy4QyLGKSKi1vchog=
X-Received: by 2002:a05:6a00:4c98:b0:847:e2e4:a36b with SMTP id
 d2e1a72fcca58-84f6b879bdcmr4679831b3a.19.1786179609674; Sat, 08 Aug 2026
 02:00:09 -0700 (PDT)
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
References: <20260807081652.38692-1-phucduc.bui@gmail.com> <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
In-Reply-To: <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 8 Aug 2026 15:59:55 +0700
X-Gm-Features: AUfX_myHjaHhMRuATtXSNJb3hMWPktXUxThFKw4KnDmx30oADvzEsWx9LpvQM5w
Message-ID: <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Thanks for the review.

>
> This is wrong. Check the if() path - the code ends up here if pretimeout == 0,
> even if irq > 0.
>

You're right. I misunderstood the condition in the if() path.
I'll rewrite it as follows:

 irq = platform_get_irq_optional(pdev, 0);
+if (irq < 0 && irq != -ENXIO)
+        return irq;
if (data->pretimeout && irq > 0) {
.....
 } else {
- if (irq == -EPROBE_DEFER)
-       return -EPROBE_DEFER;
  wdt->wdd.info = &qcom_wdt_info;
 }

Best regards,
Phuc

