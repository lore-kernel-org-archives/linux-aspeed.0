Return-Path: <linux-aspeed+bounces-2944-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73247CEE35A
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Nov 2025 22:06:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9zGC51Bxz2yvZ;
	Wed, 19 Nov 2025 09:06:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763463215;
	cv=none; b=hwKPSe8DxOwFIQwkSofC5VCy8hmdQnvkBQTqiCg5byy0RH5hh4YzCM4El38ycwjI1HPY5tzzghuqVKCaX34IkgGLRneLbMY4UQbsBrkDIgmZluON4N2zqhCN8x0HpFLIuNrb5VSxS10Ly7JL/sJlUBYsWjNRxoSgsAaF6nbJ04m6xvzjwfthlVlKzGPvQUE3IUumL3aNVvjLiR8Fed11I+HRDpl4jsDGuox7fVtK90Jrs+MOrduhEMH9oWlFNugeVwqLou5WfmjVm8vAW71YkIcK7yLb/C66biJl6Qv+lhsDqiYRIXshWbsuo32AMBVvVib8MiuePnQvcu1uaDnNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763463215; c=relaxed/relaxed;
	bh=GNWvzmtFgayxDKFBCqPDOF8dv3RuxqQ/CWFcJK3lnBY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O7BNAUS/NeUj/6CPkzLFew3aTTISlLxXFSgH4YOaLNl6G/OaWoB1mNLHmNndSDdacfdI0LBKpcRxO9NBWcy2HKN14Ii4n6kbNxdhSqmTW+x5HePI3Yi9YEzDPVj7FKcSmk/zQkCjaYjQvXN7cdN3sHSfVQ9mQIvaabyK4erFLDtCqd5LkPI/7xulPlh8GJ/SOioMHgWYEqNC2TM2NBi+rGoZgwv4+b7kFEGYZ2x4g625wIvI0qAozpUQoWcqY0KJzY6PcqXUyOnCH4eP7tkiqewzf2us+IY861qLBxRkX6iFXeLIhUdO+dL2yv291BibpVJy6pd6x4iuBf3HQA9B2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nP+nJJCL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nP+nJJCL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9hL639Qvz2xqr
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 21:53:33 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so3455821b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 02:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763463211; x=1764068011; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNWvzmtFgayxDKFBCqPDOF8dv3RuxqQ/CWFcJK3lnBY=;
        b=nP+nJJCLc0z0vq7M4b3te6hDfhmZIZ2KfWx1LZl37dh1LfTan21mnUPaozKEtxPZWd
         747QZH06Q4Z3J1GdHqsOx4aIyZFLLxQebvdGb8RwVetji3nKHk70ll21gfrG+Vkmb0Pp
         oPsZCLGHUe0OIvlaRTTCRfpRFPS4STTuyz37fVxNZHm0KOIXwPerA3jQ1+Ugn8g4DGuQ
         J/mzI0M7SsModYzxIdMRktlXtB9O85cqLPTSwfjs2x/siBr8wdmkI6hG0WwlTHijfcBX
         Kmkd+vgTcsVSbru4+jjjePLGlPYYHO86VZHwwiDtbwsDk7decXNSMJUzvLllxq8OL2XJ
         UufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763463211; x=1764068011;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNWvzmtFgayxDKFBCqPDOF8dv3RuxqQ/CWFcJK3lnBY=;
        b=Lj2BFn1aoYnjBqJ0ruvNWVgO1WySOIRuFL8wOzNb1KuDxjfpqXjBWf2DVSwdRVjlMc
         KHDxs71GGn5L1X/kji+tI8scuTfZGWtpZ6d2hGCFfb4VuMPhBjE7Yb8hgTYDDKXNqKZI
         TFQYGqCi4EfpaAh6yNgBZtcSvDBH71GNi7RqWXnVoHmYTGlSeHwSFKYTlUfTWTVZ/8Bm
         sFWMqzLn04FuodJCBK2KIgxuqzbUwB7EfaFrQLgJGuiSeQzT7FmA+kcjEudrHe0BRbp4
         asM2qwq42L+7OtpMegyC5HT5gbMXs1bExF3oOW63BGeSc86/SnrKhUxSVcbcSv05L/OV
         j+YA==
X-Forwarded-Encrypted: i=1; AJvYcCWtiPfU/7Qqa3z6xheZdinhwkeeCTQdTQa9Ix3mlVa94ilufjMJShUy7PVGHz6N8fDwSdFZgen3TMuSBD0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZsR6l3r39rjdpXm4RESyTMtUDpPb0TXAhPIFoveZSsRjmeYe/
	vTTwT3YsJnjngif4TrY6+Bee2sl7ohVS3fG6wyOrTU4Rkw7lZ+HGlz2P
X-Gm-Gg: ASbGncu1scK9rY6KTqr2Ho3VUd2NyvpYaKdeAkEwvu1/2kMfXdms6lbGzCUOQ7y65E1
	YyeTLwyPxEihkvdiGnPOLpELqUYzzhwpW7atxyAAjRhOYKbIWDR2MfweeT+x9U1cYwO6MaDN4jZ
	qpf3pKht4mWNpLkaWWE46gTFPehbObsRTvrA/YLtY5DjP/UisjT0b6uwjvEtdEwXxlvxRD+zhuI
	unw8D3BQfUjbDgePXP3CX1ifXwltM2xu1zOg4vAFtslQ0TKNdxsL+dC9tWnSaIf27K43XaKd9DB
	KlTTiO5sXLJDydEYgpjP+FCWUv8YxCdXPW2usKmEY+bkn1Lr96MQYPaYwjtKfNXhrUZCWmdqa5G
	eVbFr8i3ZB4oJp5GfRjMr8GQ7ZsIi2lRGn0uwArd++boz0W9Vq4usP+hFHoixYOGPWoaD930fBE
	0IM6XeHBXOSgxb9TKlvgMZL8jKjZkxg4d+z3r4I4Jdj2haAwP+OL5mjqb81eO1QH196rdIBXbGu
	eCsARVrPpNUbsQo7zNF8ruO7v6Lnyi8614hkmmEugKL/Xz6EmHjmgrv/2RBZfDjnv0oTkI4/rK8
	6OubczWesGzSQat41CY7
X-Google-Smtp-Source: AGHT+IEdCXwcY6BKlnXmAUl8RmB+RxuF8va+wI/WcFKa5as/7KVxKeQKOmmuuoUTbstwS+jBd1TywQ==
X-Received: by 2002:a05:6a20:7f8c:b0:342:1265:158f with SMTP id adf61e73a8af0-35ba2598df9mr19914810637.51.1763463210498;
        Tue, 18 Nov 2025 02:53:30 -0800 (PST)
Received: from 2001-b400-e30c-5507-a914-c4dd-0879-41e4.emome-ip6.hinet.net (2001-b400-e30c-5507-a914-c4dd-0879-41e4.emome-ip6.hinet.net. [2001:b400:e30c:5507:a914:c4dd:879:41e4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924be368bsm16274111b3a.9.2025.11.18.02.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:53:30 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Subject: [PATCH 0/3] Revise Meta Yosemite5 devicetree
Date: Tue, 18 Nov 2025 18:53:17 +0800
Message-Id: <20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1QHGkC/x2MQQqAIBAAvyJ7TnAFo/pKRES71V4sNKSQ/p54H
 JiZDJGDcIRBZQicJMrpC2CjYD0Wv7MWKgzWWIeInX6Tm6vIM91Ro2U0TNQ7aqFEV+BNnjocp+/
 7ARGWMDtgAAAA
X-Change-ID: 20251118-yv5_revise_dts-12e10edd95d6
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763463207; l=809;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=B61xDsu9dYZf19PlWoIS09j6kYYtBqsX7QXm1aJx68U=;
 b=yCgOZ8n1862RHQxibfMqzDonVmCN/NYAhOA+hvlCEIiGwrky0Mnhf//CgYJS8ZcvvF3N35qNf
 CwWdaa6W6g6CUHT5Te0Ec7UWyo83rnHS5dTgkOXDtkrxcm5J6jNcukF
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Summary:
Revise linux device tree entry related to Meta (Facebook) Yosemite5.

Changes in v1:
- Increase i2c4/i2c12 bus speed to 400 kHz
- Update sensor configuration
- Rename sgpio P0_I3C_APML_ALERT_L

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
Kevin Tung (3):
      ARM: dts: aspeed: yosemite5: Increase i2c4/i2c12 bus speed to 400 kHz
      ARM: dts: aspeed: yosemite5: Update sensor configuration
      ARM: dts: aspeed: yosemite5: Rename sgpio P0_I3C_APML_ALERT_L

 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts  | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)
---
base-commit: 111e542d267576de402d0836603e1def2b60316b
change-id: 20251118-yv5_revise_dts-12e10edd95d6

Best regards,
-- 
Kevin Tung <kevin.tung.openbmc@gmail.com>


