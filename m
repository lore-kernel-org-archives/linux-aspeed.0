From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 2 Oct 2024 17:35:37 +0300
Subject: [PATCH v14 0/3] Add ASPEED AST2600 I2Cv2 controller driver
In-Reply-To: <20241002070213.1165263-1-ryan_chen@aspeedtech.com>
References: <20241002070213.1165263-1-ryan_chen@aspeedtech.com>
Message-ID: <Zv1aOedi9xl2mg9b@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 02, 2024 at 03:02:10PM +0800, Ryan Chen wrote:
> This series add AST2600 i2cv2 new register set driver. The i2cv2 driver
> is new register set that have new clock divider option for more
> flexiable generation. And also have separate i2c master and slave register
> set for control, patch #2 is i2c master driver only, patch #3 is add
> i2c slave mode driver.
> 
> The legacy register layout is mix master/slave register control together.
> The following is add more detail description about new register layout.
> And new feature set add for register.
> 
> -Add new clock divider option for more flexible and accurate clock rate
> generation -Add tCKHighMin timing to guarantee SCL high pulse width.
> -Add support dual pool buffer mode, split 32 bytes pool buffer of each
> device into 2 x 16 bytes for Tx and Rx individually.
> -Increase DMA buffer size to 4096 bytes and support byte alignment.
> -Re-define the base address of BUS1 ~ BUS16 and Pool buffer.
> -Re-define registers for separating master and slave mode control.
> -Support 4 individual DMA buffers for master Tx and Rx, slave Tx and Rx.
> 
> And following is new register set for package transfer sequence.
> -New Master operation mode:
>  S -> Aw -> P
>  S -> Aw -> TxD -> P
>  S -> Ar -> RxD -> P
>  S -> Aw -> RxD -> Sr -> Ar -> TxD -> P
> -Bus SDA lock auto-release capability for new master DMA command mode.
> -Bus auto timeout for new master/slave DMA mode.
> 
> The following is two versus register layout.
> Old:
> {I2CD00}: Function Control Register
> {I2CD04}: Clock and AC Timing Control Register
> {I2CD08}: Clock and AC Timing Control Register
> {I2CD0C}: Interrupt Control Register
> {I2CD10}: Interrupt Status Register
> {I2CD14}: Command/Status Register
> {I2CD18}: Slave Device Address Register
> {I2CD1C}: Pool Buffer Control Register
> {I2CD20}: Transmit/Receive Byte Buffer Register
> {I2CD24}: DMA Mode Buffer Address Register
> {I2CD28}: DMA Transfer Length Register
> {I2CD2C}: Original DMA Mode Buffer Address Setting
> {I2CD30}: Original DMA Transfer Length Setting and Final Status
> 
> New Register mode
> {I2CC00}: Master/Slave Function Control Register
> {I2CC04}: Master/Slave Clock and AC Timing Control Register
> {I2CC08}: Master/Slave Transmit/Receive Byte Buffer Register
> {I2CC0C}: Master/Slave Pool Buffer Control Register
> {I2CM10}: Master Interrupt Control Register
> {I2CM14}: Master Interrupt Status Register
> {I2CM18}: Master Command/Status Register
> {I2CM1C}: Master DMA Buffer Length Register
> {I2CS20}: Slave~ Interrupt Control Register
> {I2CS24}: Slave~ Interrupt Status Register
> {I2CS28}: Slave~ Command/Status Register
> {I2CS2C}: Slave~ DMA Buffer Length Register
> {I2CM30}: Master DMA Mode Tx Buffer Base Address
> {I2CM34}: Master DMA Mode Rx Buffer Base Address
> {I2CS38}: Slave~ DMA Mode Tx Buffer Base Address
> {I2CS3C}: Slave~ DMA Mode Rx Buffer Base Address
> {I2CS40}: Slave Device Address Register
> {I2CM48}: Master DMA Length Status Register
> {I2CS4C}: Slave  DMA Length Status Register
> {I2CC50}: Current DMA Operating Address Status
> {I2CC54}: Current DMA Operating Length  Status
> 
> aspeed,global-regs:
> This global register is needed, global register is setting for
> new clock divide control, and new register set control.
> 
> ASPEED SOC chip is server product, i2c bus may have fingerprint
> connect to another board. And also support hotplug.
> The following is board-specific design example.
> Board A                                         Board B
> -------------------------                       ------------------------
> |i2c bus#1(master/slave)  <===fingerprint ===> i2c bus#x (master/slave)|
> |i2c bus#2(master)-> tmp i2c device |          |                       |
> |i2c bus#3(master)-> adc i2c device |          |                       |
> -------------------------                       ------------------------
> 
> i2c-scl-clk-low-timeout-us:
> For example I2C controller as slave mode, and suddenly disconnected.
> Slave state machine will keep waiting for master clock in for rx/tx
> transmit. So it need timeout setting to enable timeout unlock controller
> state. And in another side. In Master side also need avoid suddenly
> slave miss(un-plug), Master will timeout and release the SDA/SCL.
> 
> aspeed,enable-dma:
> For example The bus#1 have trunk data needed for transfer,
> it can enable bus dma mode transfer, it can reduce cpu utilized.
> Others bus bus#2/3 use defautl buffer mode.

Is it possible to switch to new terminology wherever it's possible?
I.e. master --> controller, slave --> target. See, for example,
f872d28500bd ("i2c: uniphier-f: reword according to newest specification").

-- 
With Best Regards,
Andy Shevchenko


