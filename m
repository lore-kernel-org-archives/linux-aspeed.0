Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1D606A327
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Nov 2026 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hAHsqZUA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPMbd3zbsz2yLY;
	Wed, 11 Nov 2026 10:01:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794286696;
	cv=none; b=NKBh6AU4miAlok3x+Tk1gl+vzBEA/3JsKAibNsT/RpsjYvEKKPvd4+zxwcaoTC0PuT7QjyRTcac8ln0tjiXN4MTUssFE6i0HNqCF99P4fill0xbuqiagfVp9Vltf9aUR+wb3oLSZnxW3b9KtiUx6rJIoVWuhhKCWck4fLvzYUSA60yTIlPOn8ZBdxQgMLvHYZhs0Qz4pSq4Ga6RxmNHCdTbwbpYbJ4d7ZaEBD1ZAfyZ8HQv8BV5Vy+bmnDSsREN+WqddBDAcynG0+d5fdWcWnH8tT44sD3k+IGcSFFIQ0zzvoLXQyat2Y5KwFjmm9sR7geilAHCpqLo6WrnGYSorfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794286696; c=relaxed/relaxed;
	bh=LQH6/FLfD+l3EuP607p4MXIkH0GyDF3Widek8GlB+OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+cDBL5gthKJka5JdxW79WJCWjLg09B6pcWJExjNw1eSOxDE738FQ0prKbBKqI0/7LdCPYNcg4mkFyI+UsygUkUZx2Ft1ixsoL2sg4qyuTGV7XBq4r9oqooA3ccHtNpkBq1Stoy0FOSVHZFMROzSrGh8SkDGG7XTxjkdH79l2Uu/4KczdCT3rBri2rdBGGRhbI0OuHXoJRTPVsaE3IVzffWvgt8Xsmk4CIQLtZg/lgq4kVVgw1sddsNO/veVoIDgD5yhIpGVSo+po4bVT3vCQ6jk/8+1CswDEuJg7D4gP2wxjZet7saOeEHT5JOTx+OGt5Wgq3ZX+/haJG0pPp+aKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hAHsqZUA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hAHsqZUA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNvYM13yLz2xjN
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 15:58:14 +1100 (AEDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-91e8938fd01so18174316d6.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 20:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794286691; x=1794891491; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQH6/FLfD+l3EuP607p4MXIkH0GyDF3Widek8GlB+OA=;
        b=hAHsqZUAwYvp712snw/JYPNR1zBIHI7HcHN+2Vst8K493o+085Ang+rVkrlnDIyTdh
         iJfyHPeBT8Yp3FxJRRC2VKgRFiRniNklGrA7DnAviDMgKqWjRehBJCglewKlD7bwxTGm
         OGbKyv9zHjzEVUMyxRNetsvB3RQZc8qoT4WSTmSno+l5y+WxpdjIYWd34J3M0gWOrEb2
         Yb+2bWa6xjEl8ztS5cpFdPhqCJ5mcDAzRG68za0zF7Kuo78LJC/wxWhHH7/T+JUvLahV
         vm3hdeXVgurWC8nadGGRXVRpi8wRqalI7n+bHSI+q/zMwwmGhTRhRSHUjTzgHR7pKTuU
         fDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286691; x=1794891491;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LQH6/FLfD+l3EuP607p4MXIkH0GyDF3Widek8GlB+OA=;
        b=DAK1zj4HsCs1teHyToY4UD8G0o7vQuI3T2wnMzxkDOX12LtVr0iICV97UOVZtR00Ob
         2AwOyTowlTnJVKSw0bJY6/cVn+gKH7leCWzUmtGlzGZLHJaGIeAU72Sr1qxkWsIePlpm
         urB9AXS3SsqtQqB9vieK86VdN8YMDfsdDg/DITJYcjfsuYipLbmajSAlCAZEBH5IK69O
         BRHZjmYPamgG0yqjGrTirRH0JV7IRvJFHVz/VJH8OO49liwaqx+ZXOjaeD6yan/RC9MF
         q8kn8UUh+MZAIBd64svcMoYJmqfIwOmwL0ZGmGfYXDs8zP8dP9O9VxZMC+ytnIdb3DgG
         L/Vg==
X-Forwarded-Encrypted: i=1; AL+hErHq2wl8w1eVdormCjallZMzBtvkGLqnP1tVRoxCzxfAhPyPWnB+r0pMvh17clce99yXlOFGtkaKayJU5O4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9Gef7wcjvXmONALayiF1sokutw7XdaUjvuS72w1Yp7+qSPgapM
	sM+dS5XRgbqfsUSujihYC5UgwD4FoO3rSstfiv+0FyRJDIt2kqwmpSc=
X-Gm-Gg: AYBFou3GKYjnun1l/mz0SMipP/kCXvnuipe6elZDryjiCCtBUOfRa57DnOILyAnODKe
	MjisAhbeHglOygOixm963N+Fw2qfQYfBrmj1i90BEh/iKQ2q63fiDDfMWWLj6vPqGWlrTRIeJkt
	0mxeGrjDA2gXIL/9x4deZOqJRj0VoJ/U/EXIrHmXCaScxXDrlVvtUU2PAV3RKHkgb3B0j/O+wYG
	hdMnQVfBAUGK38w2hmgiZfdBCiBoS/ZStzkMrR397op1jIYm+NGalb3J9trgBsZrHYNLYj1JhDf
	/qR9tUGgcMrkQBApDzf4Dqk+9w4j+VcdsZrzxwQRz7Ey79/uFpb+b8vIw91+WZMTQjVZcyJwRp3
	cfNkOZLz5Zl1f7nAMDyYoNe1Hf5N0vv6I0PZM+ifrrWcekTaazAsqYCCZZZIN9T4t4VGpJUXzCK
	P769igNa1JrTvAh4SvGpUyj/TfW/rYrrJ2HDpPAO69+5AFLkMuYUP/x+fGFjL11qQOKpoOpa2uX
	7XDVdcbQ5bSj7Zg7F/Uo9N7WwaoBvh9HzOh/uqaOpiBrCPskJdS1K8mNo7AbxLtyTb93t9NY7nH
	G52zO7zoaOrx2y+oyxsrDswgj/SXMzTz/d7c6YeHkY9L5WbTPmUBJZPXLRKh9JjKYUqv7ucNebn
	sY8OhE75OEv3kRbxLtnZdZzVRHRInXgMH2MvJA83X+NA3CUlmoL7H61afem4al4kZ
X-Received: by 2002:a0c:e018:0:b0:91e:c6ec:1d9f with SMTP id 6a1803df08f44-91eef9a214emr27070326d6.52.1794286691211;
        Mon, 09 Nov 2026 20:58:11 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04f89c1sm12462836d6.23.2026.11.09.20.58.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:58:10 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Jammy Huang <jammy_huang@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-media@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2 0/2] media: aspeed: order probe cleanup and last close
Date: Mon,  9 Nov 2026 23:58:07 -0500
Message-ID: <20261109235731-aspeed-v2-0-mhun512@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This revision requests the IRQ after its dependencies and synchronizes
IRQ/work before manual probe cleanup. The second patch fixes last-close
ordering and keeps the engine available until VB2 release completes.

Compile-tested on ARM64 with LLVM, W=1.
No hardware testing.

Changes in v2:
- Rebase onto managed reserved-memory initialization.
- Remove the research sentence and Assisted-by tag.
- Join the IRQ and delayed work before manual probe-failure cleanup.
- Keep VB2 release before normal last-close hardware shutdown.
- Drain the IRQ producer before cancelling resolution work.
- Balance IRQ disable/enable within stop and check STOPPED before power-on.

Myeonghun Pak (2):
  media: aspeed: join IRQ and work before probe cleanup
  media: aspeed: drain IRQ work before stopping the engine

 drivers/media/platform/aspeed/aspeed-video.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

