Return-Path: <linux-aspeed+bounces-3184-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F656E6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:55:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFXY6mhbz2yFY;
	Sat, 20 Dec 2025 17:55:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766131864;
	cv=none; b=Svaua1Hwi/KCg3pPm6I7FmeHb3Io6FrM03nSJt33wXAQxZgWlZCUvBFtVeSKULWNngkKy769BMENymLBaEMw6lwtA0oagy5aEAjExfkFHvx8tQYEiEbteaWFZbrL3zfgGscezVM8hQvG3Ydvz7bujiQD2ffX9iprQCeJyytx/EjewleVX03cStkMjsJpWV0uh+DVXn+ICmrql6B1np6mLWCeBmUn+JG2mi0CkJyPP3d0pQuL7CyfaZ9IAaHf74r42ed0RfGLdEIf9/mlSWVpvi69KW/0XQ/9pTPLYLc7C+WeXruMpUr4OS2vAQDt7qk41E+Y5YLzVeDQQRwAmeEPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766131864; c=relaxed/relaxed;
	bh=4jXO80hFld87+XUBJlo44gpcJSe53DOPS7WnRWkfxns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oh3bqdfMDREouDO5CJ5UFoULF0p0NrCaKlctlKnLmr6iwNDRgrbpKZrUyetqGU7uq+BPCgIKy4Dbgk6pWDPgnrnYGoYgm8rWWNGsFio9U++KLxFUEf7BMzpRKgbo+gZCcza8UiTMylu3h94qwn8il8q9jIGChmZZQ9Tu7vD4DJxFvAumoNM9irvTrvgHpEnQ6dey9BAX3YTx75l9Rd9mJG+qVk/9pRKDO1zCooyCs2lSNy3kEo6IJQFTUDXUMgK5Yq2vNXoTo05ZM/YuCTMAGTZW+itugNebTsH497ziD/3aOoqUIW8PV6bqGUMpi8j/f6uatfSL0iEs03L3SYVt4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=daA4od9g; dkim-atps=neutral; spf=pass (client-ip=209.85.210.171; helo=mail-pf1-f171.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=daA4od9g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.171; helo=mail-pf1-f171.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXgGH0nB3z2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 19:11:01 +1100 (AEDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7fc0c1d45a4so1434958b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 00:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766131800; x=1766736600; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4jXO80hFld87+XUBJlo44gpcJSe53DOPS7WnRWkfxns=;
        b=daA4od9gQnh+4rAZCdFljPJuhaW7Sk4eTZlKTChEyO0fhGA0kAFXuwB7vU/j/LzRel
         7AiGDshyn7iuBndF6cVpTg+M65GTfW1NVV5arg0ErWS06QpXGYzsb8qQ+4kCc1kXd/RO
         VR/u2End0A5RdHqT9dIYDc5u/la+WhlEBUwv801C00GKkyhfu4Lj79RWbgtWYogPfN+B
         iScFB9h16eeLOiWmNhd5HAEZYLz1hOnfF4GMGualFA5hymcfW4FKK8arMqJUfHZSyaQ2
         2gMQLpedigW3qEx7q3kPBcsivc659QqoOeBahVAH/k1A9tOnlr9PirS3qoJDMMa/kiHr
         BogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131800; x=1766736600;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jXO80hFld87+XUBJlo44gpcJSe53DOPS7WnRWkfxns=;
        b=YNnphmt2/R07NDPJXdqsRZvIC+LWmbSKXkfBHpghp9WANzhU1BHcRlPqFQlOEqpvFt
         3K1pO4lw2SW7v43kAe6jUJCDYrV5yN6TavvGAZ+R88qIbYOoYPAx7AKlzGsZH6pYDWll
         VJRIVbW9PNfL+koVW6xk6Lxd8HPLrO9+OPxyp9MVg7/oeo3rjj68GXnTkZOQ7cvzMjOh
         fLxDesnBcJyzp126diE4XZRuxj5dC0gCNcntz0cFTlmWqMNWm8Wa9a10G5+pAJUhIOxb
         gxBF8oq5DDsAutYWhquSd5QRVUsrqE7+a05Juqf2kRVtH6l4gNxb5yyhzsWqczolizRz
         kJnA==
X-Forwarded-Encrypted: i=1; AJvYcCVPtLsOD5hqXicvPcsvDzpFYZgx+Wg72s2mzA+oHLeWlcJ3eWT+OGtTWLZIPZmV7mFe7EWIeu/PYDNOyK8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzomrRa0qxFeUy1PVPSGtiYFk28Ra/O8jijOuUvRtrT1+D5jk2l
	3uCP7SQmhPN+MKmn5m+4fOlVkpjOUiXjl14gPNmS9lj6FKuDJ3sBeZkg
X-Gm-Gg: AY/fxX56cMCtVhwjpQ+t/4tSIuUCy3NJr09KT6weVARkE+Wklka8xTVs4LJRfGF2e/Y
	6D64y+OVzzSQQo6etp7h4jCAGs8S2D+7ws7vorpzlvyPdub9A55XfpMsirkiSe/KdZ+aUpsxYmZ
	bAUeJjfqVUYJ5kYX2FHkQ8yC/9s1dz94y7RJfxzOVS+/XrKbM7Xo/wTohSYsATmU2Iw//ES+Yew
	xPCbPaQmB1zMTlJyqoOH3bMV0opFhw43cG1ofB6THsH2C5wXHH+dLRzJWO6bduuLcbxnVSrVy52
	kyu1TTKYB9LJKDCz5rfiVEt6f1AYp6lBEsalUOi9+tNqkLu8ZpY4CHn4h0N05psYe13gLoNx2wC
	v+8k/z3LXfGk164d3k33WdUXIDz62eM1bV1xui2IijdZ6lQ4yqQo512pNyMdBDPYWvR3tE/OBpg
	m8lNAz0NdyUCpcZvWEASwph/yiLAxXgP28kEZWmck6Qp5pPTzaFmlVQ3sXARqiuOpYVb+sZYFmh
	CGgHXqQPBx0gN500yyoFJRT7OOTo4xUxccbjkOX4Z5bSchfPuGzwKIK8hlMf4rT1mqT8GapgSGt
	N8JPO8AOGqw=
X-Google-Smtp-Source: AGHT+IHKFrT2NF1JDxgj+UalkYJY1R30QBAlfTHJOdEXGM/XHA2EahCclVKDTC5GGRc12Vi7ENo8Ww==
X-Received: by 2002:a05:6a00:9089:b0:781:be:277e with SMTP id d2e1a72fcca58-7ff64401115mr2017997b3a.4.1766131799768;
        Fri, 19 Dec 2025 00:09:59 -0800 (PST)
Received: from 2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net (2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net. [2001:b400:e3ff:afb4:41b8:b31c:89b3:a14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423d86sm1597274b3a.26.2025.12.19.00.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:09:59 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Subject: [PATCH v3 0/5] Revise Meta Yosemite5 devicetree
Date: Fri, 19 Dec 2025 16:09:53 +0800
Message-Id: <20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAFEIRWkC/3WMQQqDMBBFryJZNyWTGq1d9R6liGZGHahaEgkV8
 e6NroRSmM0b/nuL8OSYvLgli3AU2PM4RLicEmG7amhJMkYWWmkDAFc5B1PuQypx8hI0gSLEwmA
 movR21PBnDz6ekTv20+jmvR9g+/5NBZBKNhazOk3jFfm97St+ne3Yiy0V9EHX6kfXUU8xR8oVW
 FPTUV/X9QsxOmB66wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766131796; l=1440;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=YinN3jx5KiGJyRVBis4l4aUW2nlKscAe0FQJeSOKB1c=;
 b=bAtRpZ2ntnmQuZ1a18aigOgyrt/3KLbe32DMiIMFO5CpRAPPBNclbxWrygkj/utJgrSoP9HNx
 NbknPcA8s32DJtdTqKH8OsoPbLmDdR3MNZ67ClWphDFGQU2C+tF8YgH
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Summary:
Revise linux device tree entry related to Meta (Facebook) Yosemite5.

Changes in v3:
- Correct power monitor shunt resistor
- Revert the previous SGPIO P0_I3C_APML_ALERT_L renaming change
- Add new SGPIO line names and rename signal
- Retitle Update sensor configuration for more clarity
- Link to v2: https://lore.kernel.org/r/20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com

Changes in v2:
- Add ipmb node for OCP debug card
- Link to v1: https://lore.kernel.org/r/20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com

Changes in v1:
- Increase i2c4/i2c12 bus speed to 400 kHz
- Update sensor configuration
- Rename sgpio P0_I3C_APML_ALERT_L

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
Kevin Tung (5):
      ARM: dts: aspeed: yosemite5: Increase i2c4/i2c12 bus speed to 400 kHz
      ARM: dts: aspeed: yosemite5: Remove ambiguous power monitor DTS nodes
      ARM: dts: aspeed: yosemite5: Add new SGPIO line names and rename signal
      ARM: dts: aspeed: yosemite5: Add ipmb node for OCP debug card
      ARM: dts: aspeed: yosemite5: Correct power monitor shunt resistor

 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 68 +++++++++++++---------
 1 file changed, 42 insertions(+), 26 deletions(-)
---
base-commit: 111e542d267576de402d0836603e1def2b60316b
change-id: 20251118-yv5_revise_dts-12e10edd95d6

Best regards,
-- 
Kevin Tung <kevin.tung.openbmc@gmail.com>


