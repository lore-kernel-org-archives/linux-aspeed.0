Return-Path: <linux-aspeed+bounces-2996-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1F6D0E6EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Nov 2025 13:59:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dG47k5yWkz2yFW;
	Wed, 26 Nov 2025 00:59:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764079186;
	cv=none; b=fG4QpGG69WAae2hHJJkUqLt3yHQ8YgSWrgFUOv1ayHld3IJN9PM80os4fbxrJNEnFOjRKFKPHXednRi6wQRIjd3uDP5apkdAvOWFw0n451wq7xIdb46N3pofhR/va/pkEl3w3wo5SV+GXrchi+j+NB5bJ57VzkN4XSYKDpHKVf4KXvXNmEX4+6Rhg5Ero6Zo7cdv9J2+37tc3C2A4NvoRuswEXW7dNcs4kVd7xdNSAr7FF4OzmaWDiDZFURux44MghanXDLNEhp3/DepUF0ch6k3ozuDwEUMh1cOSvFRoIPGW+fcvjEMRhl3jg1b4E97/Ero8A8ooyS750MTMnGAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764079186; c=relaxed/relaxed;
	bh=8Wq6qWRdMJT8JkFWrdlIBvOjsRwtEbw2p0Rqikaex0U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/DMfA8YcJYL65WIhJ2XY9sZ/aw99ekdKvk9tYWtbP5YBOJB0IHha4oWHyKx8YIYvyxyyu9cmim6H9XBJMUtUHT4G6aeQopmE/YW9CTXzeFo/jim+JDPPrpobhDCgMsFL3su+BPGV/CRXEQdRiQKtOTg4Iupg7W5Qg46MfN1zgDdUWb7TNYR5d1F0m94aD9Rvtipt374XsAZgoN72g57ff/OVL4vDx43yY95QiB9/B0kiN+06WphWX7CfvQzj77aa5DZlYy3uLbrqeRwcpHVPxN9g8BhB0mllyK/WFD9VqG7GR9PM1FoWDQDAQrmL9JOnIjbYxGPbzlwZWxqbk5mRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=S9ryirAh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=S9ryirAh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dG47k0Psxz2xqf
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Nov 2025 00:59:46 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7aad4823079so4870595b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Nov 2025 05:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764079184; x=1764683984; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Wq6qWRdMJT8JkFWrdlIBvOjsRwtEbw2p0Rqikaex0U=;
        b=S9ryirAh+FGDP2dQT0VQy1LrbV9a7QreiIMGY/P4/PHqbTjNAdJmNIZC6Xe16IWwEG
         Lgv3pQb/qNrJvydiVtSbCIHPcZiy9kjTLXBcsTYYcLVR8+mvdxE5+ymbx6qEL1oCTIRw
         YpDk1WfzQta6/AP3yUFQrMC/MEA00fBJgJ6sRC8hpGZ1rxn+tjHHEa19uOmbc/4GU58i
         Fdioe9YGpPYYZkCb/UK93vvKxjpWF2TBG9Dz4t89c+GPRHB+VmPyLtEZ5hWcEy3uE9sU
         yhveaDc90TN0xEcXfW6UUZ6ZLNVdTXZkcdyGziip77rRD4JuEVsZ7Z61BwaQVZY4xy8z
         hG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764079184; x=1764683984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Wq6qWRdMJT8JkFWrdlIBvOjsRwtEbw2p0Rqikaex0U=;
        b=c2h0N0cpA+lG8mo7+tMXxs7D+IyY7/epWk/K8pZEjT0+2fsN2yxQJ0MrBlcGZYzfm9
         T485t7qIpYPHVS6CkjE/nDn6Pq565lKmLWZayW/QoJMK1mz+nZCjHSTnjVNNMKwbu2LQ
         W+bgiu+as5WsZcCsPQz5U2WFFTOyfjM0Aj5UfnxIH/v4OJrI1D4ed4dkwiARsi+EMPXG
         Y+W7hVAfdVbN16PjXkdt+6jAx2Bt6y9PZiMfkn1AhuD70LWIiqgD140hV/Rq435cn+w2
         CWX7jyaqoPBDcfwt5+M0hqCPxW41Xn4K+uKps3VIT+aA/LsydDNZv2kdX5+r7J5ejF14
         O8+g==
X-Forwarded-Encrypted: i=1; AJvYcCV6N68oE9AYEjIwFuDzVKhepjWmyZOnzKTIbtNxLMkUDgL0HtHr4tQ1YWxLgvN3pCc2hOPx15VEzHyoVBg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzfSh2+a1W5qXNco1A3T2+TY3FX8hojabJPZqbA6VjlfIA9wFLi
	ODIbf0l6ck+34i5DkGyRRtadeE1PyP26DZy6/1HHld+P2OXHyc3BSbrK
X-Gm-Gg: ASbGncu9AM+IePJk3gG5clVqO0AGgUK+APlT5Ai0/6CeGDt+mDTvFRzDIQIeMBLHwRn
	+OgDp9h1wabXj3i2Ag87udvcP+ksVcv9I3aw53u3YfP2JKTuVVPvhBtUBtlilOvma4UIXiPs8+I
	ybu6F6d+qyrDYYjZRAj74cEAzpwOYnRDXdQpAfpGTddb5/phpFTXMExPoDelk7npOT74aX5bPZt
	5N0mLVjUvMazv9uxwXCECF/0O7oFsiO73/HDbIZeIe+ljT5M/L5+yBZX+XAXla8AVAc+/+8fnfY
	TmxdWiWRgMsfVm1JyndK3EEBkD5NlucuDIRZCpyk0ga2NFnZRfXv2W4lnuNTgzmeO1ty+WlTpTn
	IGbnvV4e9jEH6suiwmdGTFs9yLqcESzBFzFSSClxpOYR+3BoHm2eaeBDK24w0MokuwvfoXUwco7
	MU4qsk+6T5AdUzy/SKEPbPbPfQGPy3BEq+/6kJ0JRFCr9Kvg8xxzSBxTydlLd0zEKdZoMIAXrHb
	yM=
X-Google-Smtp-Source: AGHT+IGLG5ulH7QtmwgR215gpFL6u62RMBu83STuoUngtVM+z2Xb/xW3EJ/jrvfLs+uU70SnKpeLsQ==
X-Received: by 2002:a05:6a00:3d12:b0:7b9:df65:93a9 with SMTP id d2e1a72fcca58-7c58eaf27a7mr17838247b3a.32.1764079184121;
        Tue, 25 Nov 2025 05:59:44 -0800 (PST)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63dbcsm18216028b3a.50.2025.11.25.05.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 05:59:43 -0800 (PST)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: dts: aspeed: santabarbara: Enable ipmb device for OCP debug card
Date: Tue, 25 Nov 2025 21:59:31 +0800
Message-ID: <20251125135934.3138781-3-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251125135934.3138781-1-fredchen.openbmc@gmail.com>
References: <20251125135934.3138781-1-fredchen.openbmc@gmail.com>
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

Add an IPMB node for OCP debug card to support IPMI communication.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 4312ead311df..0a3e2e241063 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -845,7 +845,14 @@ temperature-sensor@49 {
 };
 
 &i2c7 {
+	multi-master;
 	status = "okay";
+
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
 };
 
 &i2c8 {
-- 
2.49.0


