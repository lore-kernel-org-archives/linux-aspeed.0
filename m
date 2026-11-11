Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D3606A335
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GDNg1GnK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPY6c4vNGz2xWR;
	Wed, 11 Nov 2026 17:10:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794377448;
	cv=none; b=gzcV/+xPjnj09qcxMWmrfFMS+CVzDLusNoQHAOb4vkx3eH5KlT2owrRm6G4lmpSf+fWj8uAkxXpUjn1JanCtA25kR4GKyBzJUn0DpJDhNq5KlbQyV9uzeztZSOaGml21Iq5AYu3FjMtcXre/uXXH1FAdLah9HVhLIuUf5Xt8JxBB02HDUtiqbL0dMxuN9YV9HHPX/5fOQG2B9KCXGldsQWmSBkSaa7vDhopYHDU1F/U739o63i7yxzbG0oWXQdAmBB1SO4QL8TPU73yatHSj/jdB0YQhqxFehB5fKxqI69NxOvoq/8jrkae1a5Xg9cFMhghot6PMR0yQEx6zZriNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794377448; c=relaxed/relaxed;
	bh=6ru8G+wIXDhbYzwCyjB0a3S3bJNBpEm6tGNjXeNvjrU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Imk8OuiWyIm6k9CXRzn9wVYqZ0i2qPwif9hoHfbG/WR83scMUQh5QeM6Uj66n9U54cUTMxmI7UpLDju6K7aPqjjXqLW7g7q20wUY4obaHQM6ddHDyM78Xb9hOnnK67pRigT2WBrL4ysUSYKRGt5rTjyAxy8r7vZaNchEGgNeFEgjptIgPkRno+XDuMrg1rWlvTHS+/p0Qa70gQq1FhJ3qeK8l+Iy72Y0CjhsLBBjg0rHhrFkrv9WZIoVMtD/2BfyCwWxHidD1GVh9cT8dGt68bstY1Wj87xS5KFA2EzGK2IYtj+LLBAq6ciRfrkMJRl+eFQmEaN7bCIAjFkwWdcbxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GDNg1GnK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GDNg1GnK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPY6Z3brWz2xGg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 17:10:45 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso1607249a91.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 22:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794377442; x=1794982242; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6ru8G+wIXDhbYzwCyjB0a3S3bJNBpEm6tGNjXeNvjrU=;
        b=GDNg1GnKLHdJsLlVGlEz2nG5CdTpqC9u6CzihZiSKKOq0Jtp4wjgs3L9ytRpNpNctF
         rf98h0GPEUv1eVim5o5nRURA5w95T0efDea05BfFSOEOe+o+vJaITrCbkJmz0GaLkaNR
         HMyKkwRJGDOjH8KmCKDNMgtmx7HZcdAFEbaAm8DL6QAyVOWOivdwAGzjF1Gf6xWXHKT2
         1+8NPGUa1dFmFrMCqJDfSj5j9OPTOA94NjUFobbRu6SSwSSV785msrR+4tGjbuJbRhWX
         5CzRXSCXX2/CTcLY9t25Yq9Nst7p1q7+XajPXOdCU4uMC9xUzo61vh/rXGCskynI4umG
         Z4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794377442; x=1794982242;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ru8G+wIXDhbYzwCyjB0a3S3bJNBpEm6tGNjXeNvjrU=;
        b=SRFLL02wD1pb4ko6xzt40NnCo5TLepf8+4/xo3Fyuxog0VpDYZqqicNzRbtO8yfk4U
         5pGj3mBAIn2CvGLWaabwXsQnV+sxZDY2dw7P54O8EWZb3ZQx2cljlmIW7YIqj8GxCBXQ
         9yj0a8vmOX5NxWzqPYE2UNVV2LfiQNn+llfETuJKGFCaik1bVVVBf9nMH5pQetMqrkaC
         8fKC1kL6infDxvROK3h/jB+8oUhLYubDAkhx3HCX1RCMizxJt6JCyETfuy9PcllgXVuP
         zC/MPdO2fBDdPx40PNdD7P7mgGs78wIIKRARw0wyuryRpNkg66aNztEShcQxkBNopR00
         OnpA==
X-Forwarded-Encrypted: i=1; AL+hErGy0rlcy7h1ue1O8urGEGZ6JyYVnbfMJ52m4voFXX+j/o8NkkMFtJmN0e4SCUdZoUx2w2hRgDxR6FAceYA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/MmuVptc/ECt7I+5fztaeI241MGlal+2ISHGpLm8u8tIVURUBO
	ERG1GKQrZ1XHfSJXUwwg0/j2gBqQO4ennntv720NKhYGrlIDLJv7574P
X-Gm-Gg: AYBFou2H0C/E9HbFZtzZYV8OSEho5I5h0ing5QaDPpoyDPHs+m/d52H75doiIxkAyQN
	6dNhEc+Di/7JNlplAiyi1VIkd23MmIKkPBUyMcadAmBaSvvYFeH/pc9WtfInMjenwYnJ2Fpg4B1
	w/u/m1b1B2BLzrKjtMzqN71WXjhWUnTN1QVd/ogAcs4XVDlMOaclqLu3OqbGRyqlCTAdbfcpJu4
	FCJtErxxQqu+k/Q3PdWSLUDDRxS3qVKQHUYuWixLDL9NckHjJeltWb4I+wb4+58yfG/upNqmjgS
	nZ2YzIdNjdM5XI9/bWJktWMs4GlVtWlKejLeqo5dYlQ5NfZYJH+RDyb42rEX24zdvIexpRenG1q
	BRwL6i875aXwK/Aj2H/kHuFOha65aB7cRuo5xXaKZLkjirxFP8PuwbMDQw5S5VYhhYk8Rk5KYDM
	I86L/VqDds1wn9Da5H7U8+rnO6tC6j7lwLU11S4FIP34VaW4biUDX+zaIjVolE5vN2t1w3eO4X5
	KChPtb1BPtXz20LexIjP5We9mcl7sqnWuQ+h5X70MgkW+kTcM+vT5GqfPwE+wkRPs2JjW+rdlv2
	aENVT34y92umknOoWGatomhSJwiPpS/ihWCnmPBMJXYmzwCfR8VDazgn1Yf4YWitnEBg
X-Received: by 2002:a17:90b:518b:b0:3b0:e388:d9da with SMTP id 98e67ed59e1d1-3b182f28620mr1681142a91.29.1794377442187;
        Tue, 10 Nov 2026 22:10:42 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db7e8b1sm2978557a91.12.2026.11.10.22.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:10:41 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v2 0/5] ARM: dts: aspeed: ventura2: Add ADCs and GPIO line
 names
Date: Wed, 11 Nov 2026 14:14:41 +0800
Message-Id: <20261111-ventura2-dts-update-v2-0-bce5b5dafc1f@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANEH9GoC/32NSwrDMAwFrxK0ropsSPpZ9R4lC9tREkHzwXZMS
 /Dd6+YAXc7Am7dDYC8c4F7t4DlJkGUuoE8VuNHMA6N0hUGTbpSiBhPPcfNGYxcDbmtnImNPZB3
 Viqy2UJar517eR/XZFh4lxMV/jpOkfvZ/LykktHSt2fHN9vXlMUxGXme3TNDmnL8eIuWptgAAA
 A==
X-Change-ID: 20261106-ventura2-dts-update-f00bc0510b2b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=UzoFWGQnfmpYqsdMkcV1qb1KoSKhE64W4DhfwwxJNuk=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq9Af0PHWv50dwK50Uy1itNGP7amluCEuos33IJ
 m8+J887J8iJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCavQH9AAKCRClg0K3CVbE
 gZRhB/0S77Vr9H7trUM/qwYjhEcN9EtmC6SAmi4fnIDqkTAG+l3Eqye63n8IOtLe7b48MdNSsbl
 qifRmlBhCqswPil5JAdCsOEW9nST16A+6pZEiO0jU5TZoivNh/VZbGrdMnHPKV8N6T/ZgL9Fs0X
 V82DdR1/gQ+yJ83UbiQIQeZuC51KwIenWTQEWWqszLtDl3FIO3CqmuWA4JF/S31uVEfd3cgwWn1
 fIGjKtlB36OGnqOG3ljRqPEsEb4YR+ItMMaQWXB2xIYDcCTA92fICinPRGiIX65S2hZffCOMuWp
 4qP+FkignX2Q2cWH0lhE539UmhWlBfqIMqOOvz8IxtCe9oHu
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds hardware description that the Ventura2 devicetree
applied from v10 [1] left out. Patches 1-2 add the LTC2305 and ADS1015
ADCs. Patches 3-5 name GPIO lines that userspace uses to detect the
COMe module and to reset the USB-UART bridges and the 88E1512 PHY.

The LTC2305 ADCs use their internal reference and describe no
vref-supply, so patch 1 depends on [2]; without it, dtbs_check reports
a missing vref-supply.

[1] https://lore.kernel.org/r/20261016-ventura2_initial_dts-v10-0-a546659a084b@gmail.com
[2] https://lore.kernel.org/linux-iio/20261110-ltc2497-vref-optional-v1-1-35c9657f3c0f@gmail.com/

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v2:
- Added the ADS1015 ADC (patch 2) and the 88E1512 PHY reset GPIO name
  (patch 5).
- Reworked the cover letter. (Andrew)
- Linked the dt-bindings dependency.
- Link to v1: https://lore.kernel.org/r/20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com

---
Kyle Hsieh (5):
      ARM: dts: aspeed: ventura2: Add LTC2305 ADCs
      ARM: dts: aspeed: ventura2: Add ADS1015 ADC
      ARM: dts: aspeed: ventura2: Name the COMe presence GPIO
      ARM: dts: aspeed: ventura2: Name the USB-UART bridge reset GPIOs
      ARM: dts: aspeed: ventura2: Name the 88E1512 PHY reset GPIO

 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 45 ++++++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)
---
base-commit: f4dcbba2ec358f7079daddcda7594dad9746326a
change-id: 20261106-ventura2-dts-update-f00bc0510b2b

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


