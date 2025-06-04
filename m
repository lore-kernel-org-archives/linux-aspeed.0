Return-Path: <linux-aspeed+bounces-1311-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326BCC5B549
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Jun 2025 14:35:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bC99l5z9Wz2xXP;
	Thu,  5 Jun 2025 00:35:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749047755;
	cv=none; b=eOelvY7vqSzTrTlmvDLFN9Wt5PI3cZ5q8mTwPXNrfzuaoWDzUWsu3n/cdrU8OP+n5LUdDMcangf+VGF2Fc1WlAoicMzsrlDdPRheBwxMuu9uFy+gXfMkJqtMlufBli08g3gvRsjJBiOux7Udwtwfz5SmNTwISFD3dYIeMpgXFq2UqKEC3mi7KolnuFEjEOLN4fOHStXReP8CIv56BFqr0vhzf2MVMMVwvHc8PMUldB1qHJwgjrtN3HfKG3mRooDhRQztB5uRBNsTrYyWMeQuwwLD01ifLiywaNClSfvaTd6MuDf8F2H/XgogU2B1/j/BtnLy9ortAJN4chXgD/I9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749047755; c=relaxed/relaxed;
	bh=LK6VpX04SwtO5xS11sN/O8n+68gw/07ItJasjDmV1c8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=PwFhGy89M6vIy95mD3QhDHsvZSOWX7OVXUxteMVc3t2uHBYbMIVXJh1yx/wdko3MnfhXxfuVtj/nxnoyU+X5o2rxSZtXqvH1RsU3PJTWztT3JClj/dzMA9OUy0SnkxNEMiNoT9/nY/aNVaWG07XnmDnxSjKhwrClNyQJBvcreatYtLtg2kfcwVQpofvQbhg4kHE/KarPqak/2RP9a6dqqcLqZnGRyX2RmWk/9Ehz39wIErUKUM6eDFF2JwHn+KOM2KFOyVlC+8PXQlAnBmQJc0jPuPVXuUfKbewrTuIYqhK81wUO02tNO72rP3sGR9RzXFsE1Y/uYMoXzEIQy2b9Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H23h20oS; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H23h20oS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bC99k56zNz2xGv
	for <linux-aspeed@lists.ozlabs.org>; Thu,  5 Jun 2025 00:35:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7029DA5044C;
	Wed,  4 Jun 2025 14:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA53C4CEE4;
	Wed,  4 Jun 2025 14:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749047752;
	bh=5t5I2NI/JMw2bEnJTqzhPKY9bh0Wo+3tCVbzxMva+CQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=H23h20oSkr5wnFXM8TFWBPGBAlo37cL9WeSh/3XpfRiqO85sbEluXHlyKDm6X+t4c
	 QxYRJ3LVtLul3FRNiRQzBU33RJVk/E2DSICZKHACGdrVOiF0pwy7YNX/utROFlN0xO
	 hkh/cOB0+K4gsRhr9bQV1KcPc3R+vMucXPoCviDd9Rz11hGxrmIj3xgQMPN3Gq0XXD
	 ydSmYx9TTcSovNlXaONNOmh7clCqKil33EG5EoalAZWs4zpkpwGdPjU8Em9EZe46Nn
	 ywAnKMrukcXgt2qVw3z+13ID6t4yYshD2Wy7cImNWDX/CVuTRNOUQPq88FigswQ5op
	 ybAzCNkTM9Ehg==
Date: Wed, 04 Jun 2025 09:35:49 -0500
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
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
 jassisinghbrar@gmail.com, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, joel@jms.id.au, linux-kernel@vger.kernel.org, 
 andrew@codeconstruct.com.au
To: Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <20250604125558.1614523-2-jammy_huang@aspeedtech.com>
References: <20250604125558.1614523-1-jammy_huang@aspeedtech.com>
 <20250604125558.1614523-2-jammy_huang@aspeedtech.com>
Message-Id: <174904774987.4021667.10220150728052993146.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC


On Wed, 04 Jun 2025 20:55:57 +0800, Jammy Huang wrote:
> Introduce the mailbox module for AST27XX series SoC, which is responsible
> for interchanging messages between asymmetric processors.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  .../mailbox/aspeed,ast2700-mailbox.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.example.dtb: mailbox@12c1c200 (aspeed,ast2700-mailbox): reg: [[0, 314688000], [0, 512]] is too long
	from schema $id: http://devicetree.org/schemas/mailbox/aspeed,ast2700-mailbox.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250604125558.1614523-2-jammy_huang@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


