Return-Path: <linux-aspeed+bounces-4268-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D36CD98ED
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Jun 2026 00:03:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gggt35txsz2xBb;
	Thu, 18 Jun 2026 10:03:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781701827;
	cv=none; b=VtIdSR4IV1DryJW2mIiNzxoEHBaxbSjew0S1cO5yCWqrbFWsThXddsHpVf1ofHRGiU1ZiQxWX75zs82dpu2l+/YF7VqtymGlGT/qO417bWWAI0a50VhHynCOuqt6w05BuA68C9Bn7/lOcqkwuNLZ9s7mRTUkPeeoDOpZ69QVdsWUaoixMVHR8q2UZQKXobyXvqjpkC5DYMtWZ17Pjpolskec/0qCGLJx1ne2tnEBAqRsM/k5Blf3Tvoccuels30U6DYixP4nCcJ4+bt05ekHsR+KauE1/crHj54U/6n0pxG3l6ZZ3D/fKfcrxpJdzHqEopsQXplSrWQCKsoH337Ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781701827; c=relaxed/relaxed;
	bh=t59PWFHJyhJPrhG4yxJtzulsV5BlqsFtV0EzJW4vR/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx8Yd5oUR7zEQpQRAGrwqsCEExgBe2VmEiCneTu0Y+80fpEuN6oNFV9rnTj0zFKyecvTzpa30vo5jc4f4EmYBRNGZv+6X/h1flsPlbEa4Pgoi+R/+4QZugT+wsF2Q1lU25dA4md2Q+4CX0nfu6JBK4Z1c28dbnOEASdN9BC/DWGZHGgNET5HYoHW8dqZ80j8KIwH+U1+rds9SYltsJhGel8duy9GwiC35Lbk7ORWN5fxNS6TjQDufSBTH/BFdzUYYVAiqaZTaVGa57lzBXvug4iaO+VznPuTYZAZ0kA+pUIVnwtwLHfLSmPdasu3WYtLnvP2rhdig3EmbzXLDZdSSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rmFDRNW0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rmFDRNW0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggPNd5tnHz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Jun 2026 23:10:24 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8423efad617so3519659b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Jun 2026 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781701822; x=1782306622; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t59PWFHJyhJPrhG4yxJtzulsV5BlqsFtV0EzJW4vR/E=;
        b=rmFDRNW0VzSBByskcBb1XfS0H36WfB4d1xkTGaVyBpHDGDHfnY5Nguzsc75wSFqueR
         4ou7/2tCJmVcPsVcLsuixjvpKw6zNLUKuO5HNZi+wbRc0lslB4RKWCEf07bbWb3RBS6q
         9XoypEi4BH2gNccoQypdXyipytANXavtJz0d0IRVqLejb1TVHm6cq3W7z5Sx5vf+jM4/
         99iP1/bOnd93tX1v3TxbX0hMYOS45TiD0S+885b7/aXvZtP4wVTEPmib8cZmtBT0h5mH
         pc/3SvVvHS5OCLXv2ly/13A64IvewcjQh23lsyuQmAb/a7JoTVWLSae/6d6mo7uSjsD5
         qS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781701822; x=1782306622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t59PWFHJyhJPrhG4yxJtzulsV5BlqsFtV0EzJW4vR/E=;
        b=J3kRzI9hpDWt8qVObW8CVA0jyPGUztz44wqzNam9fgb1M0iIhUOuOZDzRpt1jmgkMQ
         FObksB9/N+Cha/EqWMAcYpkNJOdcCyylOy6zBZxPogsDH0Wk4OFWUVTT/mxM0QPxLsFg
         TYk1oFQW2zoDB0kDP6bNU6ksR/mLhTlkg3VZmkA4jnUHRIJ0n/C/4A46jouOxLC4c3/5
         9vdVKilM6w2/o5AcoPhLgpUlUR4xQqLtaSve6IJYBeJMfdMXvQZeNZrAyEHdvgC/2Zbf
         CcN4HFS6of/+SFXW5a3nmgNLBgLhGjjSMlzaBB3BX18tCw7RS5aa5HdzGx+UHzFEMqCO
         LuMA==
X-Forwarded-Encrypted: i=1; AFNElJ/GXQTSHOHy7UvNG0/JiVoix97ehBXu2z4hqsJq4Ql/e78hOaNT668djw7TCGqsrMdnv72n4HA6UUPjuI4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxyikYuayvbWMMZ/7joYkFy7X1t970nNTp8b6mYHzpM1qWQjCbi
	nC/5emyUx8Yvd7YjJkfkIkfS/ON+oyVmCY4gbczjykLHctS4PcM01/Oe
X-Gm-Gg: Acq92OGvj0b0ufqlzCME0LCJ+2mP6QS80QiHazKboO+avqiW5MP7gfbUmXaVOqvYKzM
	Pvb4Kj6v3FJ4yBE1DmuTkoejiQWFmXz2S01C1Tl8COFjonbNkS20p8C6g1HjM3K/MLZaLpza6hk
	uVazAdxo8Lhp4Lh6PqaU93Lc1jANOdNMnr1i2LQaqFSmVU3uAuJgfaO5je0fI2K/bCqvh0ogu8H
	6s8BZzROsuIX3zrA3owjOxmJlaHRl0xZtzykga6hrZ2vR+031OAlRkrgWBBdzlBagRRgoM/iXrH
	KeGMMlMOCntxtBmgRoC7uB1MUkuZWRY6HQlSYsDz2+HSRcL0N1Hz2EDTqv95ctCLb74Kv/25x1K
	TpB7yA85byP1o4LSHrgyxH0cuWCMv6MEQ8je8bBEOoNNK1hUVWSJHfEF4flJT2LZewEFRXSCxsf
	1bYAxR1NbJElL9NezIJ/ID32DG2rnzaVxE8Wz0GFI=
X-Received: by 2002:a05:6a21:a81:b0:3b4:bdd5:2f8 with SMTP id adf61e73a8af0-3b8b7cd6681mr4444974637.38.1781701822431;
        Wed, 17 Jun 2026 06:10:22 -0700 (PDT)
Received: from LAPTOP-97G9G880.bbrouter ([106.51.148.76])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8893894debsm1085376a12.7.2026.06.17.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:10:21 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Wed, 17 Jun 2026 13:10:13 +0000
Message-ID: <20260617131013.64188-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
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
Content-Transfer-Encoding: 8bit

This looks like a lot of heavily LLM-assisted effort. Please review the
relevant documentation, starting here:
   https://docs.kernel.org/process/submitting-patches.html#using-assisted-by

==> I partly agree. The code and bug analysis are done manually.
LLM use was the out of tree test harness and lightly polishing
the commit message. None of the submitted code is generated.
If you'd prefer, I can reword the changelog in my own words or
add an Assisted-by tag ?

V1         was a simple clamp
v2/V3      was a simple locking mechanism which is pretty straight forward.
V4         bounce buffer, modelled on gpiolib-cdev (acknowledged in patch)
V5 and V6  entirely your review comments (__free, scoped_guard,
           kfifo_out_spinlocked, __guarded_by, context analysis)


I feel the testing strategy is pretty questionable. Any invariant
violation is possible with that type of meddling.

==> The underlying bug is a kfifo SPSC contract violation. My intent with the
test wasn't to simulate the race itself, but to reconstruct the post race state
specifically where (in - out) exceeds the buffer size and show it causes a
usercopy overflow in the unpatched code, handled safely after the fix.

==> I take your point that forcing that state can itself produce violations that
wouldn't occur naturally. Since the bug is provable from the source but hard to
trigger on demand, I'd rather ask what validation you'd accept here?

I was interested in whether you drove the interrupt sequence via
emulated hardware. I asked because upstream qemu doesn't currently
support the snoop device.

==> My apologies for the confusion, I mixed up things. I have not driven the
interrupt sequence in emulation; as you noted, upstream QEMU doesn't model the
snoop device. I've described the actual hardware context below.

In v3 you said:
   The issue was observed on physical AST2600 (dual-core Cortex-A7)
   in production under heavy POST code traffic during concurrent
   userspace reads.
   https://lore.kernel.org/all/20260527175939.2939714-1-karthiproffesional@gmail.com/
Is this true? What platform did you test with?

==> Yes, the underlying failure is real. It was observed on an AST2600-based
production BMC running a vendor BSP kernel under continuous host reboot
cycles. Because that platform can't currently be brought up on pure
mainline without substantial out-of-tree board support, I have not run
this exact mainline patch on the physical silicon, observed under the
BSP kernel, not yet verified as the mainline patch. I should have made
that distinction clear earlier in the thread.

==> If there's a way you'd consider valid for validating a fix like this
without a full mainline bring up on the SoC, such as a targeted kfifo unit
test, or something else you'd accept.I'd appreciate the pointer and I'll
do that.

