Return-Path: <linux-aspeed+bounces-26-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A45CE8E76
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Oct 2024 13:45:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ6cy51Pjz305n;
	Fri, 25 Oct 2024 00:45:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729777554;
	cv=none; b=BjTpNEHNS9Q0I5iQP8jRWTRzjzQp7fdJFxI/btdKrL8RgRVYB8oRpsyYX/JRB+qpBekWdMtr81qalV/jDTFFxjRm6/B56wiWjHpNiJDXYtljsOVszeWad1ceAkgdFj8YUyrxW+nx+Ql2f1sQrnh8e9wiof/lafhjh60nry0h2BHF/HC28Xb6HpqVIrMnlB7QnOzAsFycXJiYogYo1g8PfxowKLMlCEcjVTODzcR1eDj7Z9j9Twv6oQkGC+Q0nrQmFIiamepX2rhZTgUlbvoNPDscy9BqgAy4641NjhhuHaMmM5BbZZIsVWbhK7ur2BTm65lpX+FdQblz9AUPuU9s6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729777554; c=relaxed/relaxed;
	bh=H22z+1DKblhixrrQFnavIFVOTl1pYEAvrFqvlkNkAyM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=J7wt/ANvvqjc3Moysmcxs6BL9z2lp2N7VzkgZlGLuZ06jx9aOFzuRNogBXZC80S2abiTfy/F6JRTMau9XRUNpXF0VhdEqAJINtGVbZmCPrT8JkgU4abiwfkzVLyvyj2A2cuuLrxNWszzt87OAAb0gE0pESB6Dazd4dLPzwZ2iz9JqJvJ3qzu8k72/exUmHC0ysvJdLGvwP9yeIRl7ghvz9CfyoxEmU9IH7FMElMnt9L7pbIVsswDwR3ZHyRQGs+Tbb4u+u+yshsqg1Sy48wml+FwnTtvs8S5RKjQXvE2sRCdk9C5pqUnWbyStPJc1r8+E3Xg04GWpUcy+gI8TV6xYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tvZhZ/Wm; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tvZhZ/Wm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ6cx4MNgz2ysv
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Oct 2024 00:45:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5140F5C5FBE;
	Thu, 24 Oct 2024 13:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AA6C4CEC7;
	Thu, 24 Oct 2024 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729777550;
	bh=wwPWvSBGUvSYbh2tv8Xhy1j32pV3xMYlKdte6yQ/l2Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tvZhZ/WmfNUnyiKb5Ug+aYDARYpCaIaVruHf8RzheKEtrmA119942UEAyYXBDTIu4
	 Ij802krosYUO8QjsIiY7S0l0fkv7KWTLyVjKzJiRB/8+PTeYVyR2729dlbrS4xic9S
	 i3PNz0/nt5WYqKx5CZyeN+2RNC119c467bPSf2U7pLq/cBxS2XnRgjaLRKVD4e8Y83
	 +UUneGva/+KcjKgregL0zfY6OLdFOU1kuzilwUBX0YPJwC8zmbGVzpBYBfKWUQv4a8
	 t4htVWQwwVJ/KnXYfHbiTrWlisRfL6nwN8GK8ZwIgJSw3v0WKo6f8UMq9Y++my8OXd
	 vXDn+M6UHDTqA==
Date: Thu, 24 Oct 2024 08:45:48 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: BMC-SW@aspeedtech.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux@roeck-us.net, jdelvare@suse.com, krzk+dt@kernel.org, joel@jms.id.au, 
 linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, ukleinek@kernel.org, 
 linux-aspeed@lists.ozlabs.org, andrew@codeconstruct.com.au, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241024071548.3370363-2-billy_tsai@aspeedtech.com>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <20241024071548.3370363-2-billy_tsai@aspeedtech.com>
Message-Id: <172977754729.100390.12938687199677719303.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] hwmon: (aspeed-g6-pwm-tacho): Extend the
 #pwm-cells to 4


On Thu, 24 Oct 2024 15:15:47 +0800, Billy Tsai wrote:
> Add an option to support #pwm-cells up to 4. The additional cell is used
> to enable the WDT reset feature, which is specific to the ASPEED PWM
> controller.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Change-Id: Iefcc9622ac3dc684441d3e77aeb53c00f2ce4097
> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dts:54.48-70.11: ERROR (duplicate_label): /example-1/pwm-tach-controller@1e610000: Duplicate label 'pwm_tach' on /example-1/pwm-tach-controller@1e610000 and /example-0/pwm-tach-controller@1e610000
ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dtb] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241024071548.3370363-2-billy_tsai@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


