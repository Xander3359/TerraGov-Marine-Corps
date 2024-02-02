import { BooleanLike, classes } from 'common/react';
import { capitalize } from 'common/string';

import { useBackend } from '../backend';
import { Box, Button, Divider, Section, Stack, Tooltip } from '../components';
import { Window } from '../layouts';
type Data = {
  hasPillBottle: BooleanLike;
  currentPillBottleAmount: number;
  maxPillBottlePills: number;
  hasBeaker: BooleanLike;
  beakerContents: Reagent[];
  bufferContents: Reagent[];
  transferMode: BooleanLike;
  categories: Category[];
  selectedContainerRef: string;
};

type Category = {
  name: string;
  containers: Container[];
};

type Container = {
  icon: string;
  ref: string;
  name: string;
  volume: number;
};

type Reagent = {
  name: string;
  ref: string;
  volume: number;
};

const GroupTitle = ({ title }) => {
  return (
    <Stack my={1}>
      <Stack.Item grow>
        <Divider />
      </Stack.Item>
      <Stack.Item
        style={{
          textTransform: 'capitalize',
        }}
        color={'gray'}
      >
        {title}
      </Stack.Item>
      <Stack.Item grow>
        <Divider />
      </Stack.Item>
    </Stack>
  ) as any;
};

const ContainerButton = ({ container, category }) => {
  const { act, data } = useBackend<Data>();
  const { selectedContainerRef } = data;
  return (
    <Tooltip
      key={container.ref}
      content={`${capitalize(container.name)}\xa0(${container.volume}u)`}
    >
      <Button
        overflow="hidden"
        color="transparent"
        width="32px"
        height="32px"
        selected={container.ref === selectedContainerRef}
        p={0}
        onClick={() => {
          act('selectContainer', {
            ref: container.ref,
          });
        }}
      >
        <Box
          m="0"
          style={{
            transform: 'scale(2)',
          }}
          className={classes(['chemmaster32x32', container.icon])}
        />
      </Button>
    </Tooltip>
  ) as any;
};

export const ChemMaster = (props) => {
  const { data } = useBackend<Data>();
  return (
    <Window width={451} height={700}>
      <Window.Content scrollable>{<ChemMasterContent />}</Window.Content>
    </Window>
  );
};

const ChemMasterContent = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    hasPillBottle,
    currentPillBottleAmount,
    maxPillBottlePills,
    hasBeaker,
    beakerContents,
    bufferContents,
    transferMode,
    categories,
  } = data;

  return (
    <Box>
      {hasPillBottle ? (
        <Section
          title={'Pill Bottle'}
          buttons={
            <Button
              icon="eject"
              tooltip="Eject Pill Bottle"
              tooltipPosition="auto"
              onClick={() => act('EjectPillBottle')}
            />
          }
        >
          Pills = [{currentPillBottleAmount} / {maxPillBottlePills}]
        </Section>
      ) : (
        <Section title={'No Pill Bottle Inserted'}>
          <Button onClick={() => act('LoadPillBottle')}>
            load pill bottle
          </Button>
          <Button icon={'eject'} />
        </Section>
      )}
      {hasBeaker ? (
        <Section
          title={'Beaker'}
          buttons={
            <Button
              icon="eject"
              onClick={() => act('EjectBeaker')}
              tooltip="Eject Beaker"
              tooltipPosition="auto"
            />
          }
        />
      ) : (
        <Section title={'No Beaker Inserted'} />
      )}
      <Section title={'Buffer'} />
      <Button onClick={() => act('CreateBottle')}>
        Create bottle (60 units max)
      </Button>
      <Button onClick={() => act('ChangeBottle')}>Change Bottle</Button>
      <div className={classes(['chemmaster32x32', 'bottle-5'])} />
      <div className="chemmaster32x32 pill bottle" />
      {categories.map((category) => (
        <Box key={category.name}>
          <GroupTitle title={category.name} />
          {category.containers.map((container) => (
            <ContainerButton
              key={container.ref}
              category={category}
              container={container}
            />
          ))}
        </Box>
      ))}
      <Button onClick={() => act('CreateAuto')}>
        Create autoinjector (30 units max)
      </Button>
      <Button onClick={() => act('ChangeAuto')}>Change autoinjector</Button>
    </Box>
  );
};
