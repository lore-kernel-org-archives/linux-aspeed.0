Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589D606A31C
	for <linux-aspeed@archiver.kernel.org>; Sat, 28 Nov 2026 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWz8+gZo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc0jw6lCFz2yCP;
	Sat, 28 Nov 2026 17:29:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795847348;
	cv=pass; b=BL8ON5+WVQCLLAOkPIxNVyVZYgtmEXekWNlntew8bhH46GobJi3ZbgwvuVWm+LIftBITWtkT1UxA5CvBOl64yugEKH3SUV5XR138inttWe0PKslh/Z5ondmZ7XUz8Ii1m3BXFCJAegCK7y+iWoaNRHve69qpw1iHoP0jlgzltt/6iXHcRXyFcLMIokBYRp186LSynNl+TQzf8AAUPEXTrJqj+TubhdpVhow5p3wLO4hFIe/puCD0MPG7JJA9CdD3lMFYxNJZqIbP0+vimuUDW8MZWTcfupvlCHKasJw3IQ8c300fHITH1RvzmGDIHexZl2nf2srhz2qaDIZx1jMgRg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795847348; c=relaxed/relaxed;
	bh=WGy4M9NnNnT7ccatKaR8cdpvjDiDQKw52syGEgVhnxk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mL4rkEMDVj0pXguCP1+LJM+A8Y5qRGUp2vUHQIr9geYDYXLGE0iqMnkBBWEhMN0hAZ26lkLPU6mANaR2XWvoLd4KMRtAI/qOv+ulH9JqgNX7g6is3gahKN4LUgFP2JBTj2Fg5YwraGjMp8u83+TZZ0HAFu5XFwSGP01TPV+jWDwQ+ShlVjza2BOCGppyh/Vthpv2Mepg1IGZCXD0DVNRGZ6fZ2N2w+qB07aKmILv0IJOld/nObKpVWHz0eYE5iaz3ouBO+UFrIDf/6OmgkS9ffZHXb+9GClu3lCiSWxlgf0BUZJYQEihhztb9lj9uoPPltxC3tx57a5Va/0n5jWEdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWz8+gZo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWz8+gZo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com [IPv6:2607:f8b0:4864:20::b12a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc0jt75HTz2y97
	for <linux-aspeed@lists.ozlabs.org>; Sat, 28 Nov 2026 17:29:05 +1100 (AEDT)
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-67990a45e02so8930434d50.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Nov 2026 22:29:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795847342; cv=none;
        d=google.com; s=arc-20260327;
        b=q/BV+uWHb+GSdzgJAlntZxJnz8nmnt+kv2FFb/C3SbS3rGoafoke+zfegVmsq7e4nq
         W9rPe0FNuC7SuwXvJpREuAsoCgYoFVHMeWvKVlP0SgHnomA6DAhpi/iQgNcT2/q3i7xS
         cqxd1Xt+a7PqUMknWBkT3NI4V8ujsLhwXr3553WEch6zhXtGW4u88BmE914YaALyEtMb
         D5HjwCBj3wrBH0p/jTdwTgEczmVSjzZid5Sc96s1j/r/Apw+EnMCsrJv+dgLfVsvDgi3
         HReXJy2glFZVxujunln25I1TGcyIPUjnTRRSQtLCAHwjygFQGZpKoZQobjVxHLwT/KC/
         hFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WGy4M9NnNnT7ccatKaR8cdpvjDiDQKw52syGEgVhnxk=;
        fh=DqRqucPwUxzMMF0A68xuTl9l0beUBpH4Pk+sBUieuFs=;
        b=g4jjhSEE9bAO1OrCr1puWpOkP5ukLfXtPjMSGrPD8rnbccwppX4VvdCn22r/BgF8ad
         tryiw+NdXP2HM9indoB2oWMLq+dNYztuu1Dxn7tLbSI8l2xn+6hlIreJr8EWsyWDQeny
         Y1YRcHj7DvqmepNDwTOXod1sZCnFnsB2U8P1uBXSxEZZ25ZWckR38WR4NCfPQwJVGy27
         EwNP+NnIt7diqCCzGvsRSBRn7CK3yFwJXwr5/bhxI9qHUoIS3kDVv+93c7VYRSSONXVQ
         dlZHI18ODOfr2RLk4g5hZ0Hy5xoTZCwrxXJLuR/9GfYx1XWCL6rifC19H2DIh7ogxIMT
         Oy7A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795847342; x=1796452142; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGy4M9NnNnT7ccatKaR8cdpvjDiDQKw52syGEgVhnxk=;
        b=rWz8+gZoGvB1uiuJHZLPKl08LXaXiY3FUhz4hIiZxqEvuFFxvZH3JXodAuAooIreW2
         +QgDbBPXOjFmBmC9ZH4psk57J4CSAyigNam1xYM8/lmVSBo1jYIDSmq4SAXDYgxz80Wb
         v6D//Z4pF0NckU7KWvM5JcKZd+Jbc3T5AfPh4dRuO0NIqs9pt1J+4QyrHpD6Jw4WSkuU
         11QeRjAF1HgwKLycsOC9YJIksKf7zbKnskXL2T3/IrwRvexfg1f0DPzQKjSEpHXO3wcr
         rX98ai9LKS6xwPjxTJ+9ETube7LyleyOLzIvQwfylUmDHgfGY9h3J/zuD9FaJW0IUucV
         tDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795847342; x=1796452142;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WGy4M9NnNnT7ccatKaR8cdpvjDiDQKw52syGEgVhnxk=;
        b=Y+KC7nDHIPhFsG4L3CIuCHGsNARHOLspSxzlMj8ro1ED0Iz/do81F+6BRIqO1uLSql
         QLheE2JI+QzsrZSDPcq/KOj3EUonMBFjvv+q8ACxnQmmFtMMuWnt+d3IFc7ONrA2mLYP
         LMSgTGiC+VF79eULx5GJz6fb02QimMCtrATKeqfg3SvkpZhb7jyfqMFSHttX2MHO/UY7
         11Xrov6R6hAcxqBGjlKE0djEmPkOCqGFU1qcBg3X4zqdUCNZ4OO0Sc/sKr8xJfII6OtG
         DQDJs7iA1c45zzgHp82Y9qWAbpUllDl0EaImd4YZBCu18WKAqmErgk6ii4du849d2wAs
         0J0A==
X-Forwarded-Encrypted: i=1; AL+hErGc7SH+wnNfk3HOOh+lNhggSnd2w5/Od2t2lv1D/edoMN3Abzac2Au1RsQ08sd7elNXPwWpMfdHfRBFS5E=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8+TxN3WZooa0aU0VXcASp+g046kOpCsuZS5WRumsdkxEUEbgY7
	v/76JvXCnN+heWv9lfhI/LewIOBywIYI0DOuMTCAlhYM/DXC1eE8i3adcxHCeU0lsyNAh35bMiO
	uuBKrMu+PH/T7kEfpLiK4m29sY7098nA=
X-Gm-Gg: AZFdTZd/BGtC37Qm9wcN8elX9VnHBmoh+Mz7Vk7c2rrdzcT+PlXow1+IO7RQn31Hswa
	nmYtTZiQuLJv1i3JHF9wA7Hg3WnptPT5EUtBJ3d9kJZY2YaZiApFhW5S7bf4Ry/vPqhOLQoK1fJ
	LkyK5IPJjUF160XYIKHKbDO01Z1ckpFcEEh7ITrk5MXvMgRszA2diDxNMofrknPVTY7TupH9rv/
	EylIgYnnbAjn8FHp3UOz4zs6SOnoTRlnTi3iV9h4dYH1qJVhIaNI7kphk8ysSupMFRW/KLOo3uz
	cTtZsSdyDiYHDNnUp28SVwvucS93Q5ldsBlxmsRHszHoDdcLU5Ds35HD55CS5l5L1tjZl+iMfYt
	yVAx9A5ZiAe59Qdkr4RNplvZrGIV6ou9Ehwnl/A==
X-Received: by 2002:a05:690e:12c1:b0:67d:c4c2:1761 with SMTP id
 956f58d0204a3-67df44bf83bmr14718602d50.103.1795847342534; Fri, 27 Nov 2026
 22:29:02 -0800 (PST)
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
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Sat, 28 Nov 2026 11:58:50 +0530
X-Gm-Features: Aa3M54r97SvthWJYQOD1bAfP2maY5OTHxZfMiOxGrpQfqlCdJCEWNbxQgTZfwTc
Message-ID: <CAMFFDGg26O-ex2fKH+x1ts+yXcfARkbr=Rk2vjUNaiAxf35N3Q@mail.gmail.com>
Subject: AST2600 A3 OTP programming: hardware questions for OTP Write Operation
To: Neal Liu <neal_liu@aspeedtech.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Tan Siewert <tan.siewert@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Subject: AST2600 A3 OTP programming hardware questions

Hi Neal,

I am working on OTP Write Linux driver support for programming
readable AST2600 A3 user data with ECC disabled. Physical programming
remains untested. Could you share the programming guide or clarify the
points below in a reply I can cite upstream?

1. Are the downstream A3 MR/MRA/MRB and SEC08 normal/soak values
applicable unchanged? SEC08's documented 40-ns units give 200 us and
600 us. Are clock, supply, temperature or charge-pump prerequisites
required?
2. Should verification reads remain in normal/soak settings as
downstream does? Is RETRY=20 appropriate, and may already-set
programmed-polarity bits receive the initial pulses that otp_prog_dw
currently issues?
3. Is otp_write(0, mask) required before every pulse? Are any
additional completion, protection or readiness checks required before
command 0x364?
4. After both idle flags are set, does SEC14[9] reflect that completed
programming command? When does it clear/update? Should SEC18 or
SEC14[8] also be sampled, and is protection rejection safely reported
as EACCES followed by read-mode restoration and relock without retry?
5. Is 100 ms a suitable programming completion bound? After timeout,
is relock-only plus blocking commands appropriate? After exhausted
verify retries with known-idle completion, is restoring read mode
sufficient?
6. How do SEC50[5:0], the fixed secure prefix and CONF3[29:24]
interact? We currently reject nonzero extra-program ranges rather than
guess.
7. Are the first 16 data words, patch descriptor range, tool-reserved
patch tail, ECC storage and final SLT pair the right initial
exclusions? Are there other silicon reservations or repeated-program
restrictions? I understand key payload/application ownership depends
on provisioning, and a board burn-test allocation is not supplied by
the silicon datasheet.

The existing board tests cover configuration reads, preflight and a
guarded no-change engine request with zero programming pulses.
References to the public downstream driver with any necessary
corrections would help.

Thanks,
Prasanth Kumar Padarthi

